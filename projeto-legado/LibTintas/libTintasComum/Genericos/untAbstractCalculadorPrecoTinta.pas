{*********************************************************************************************}
{* Classe abstrata que implementa a interface ICalculadorPrecoTinta responsável pelo calculo *}
{* de preço da tinta ao todo, retornando os valores para o Autcom                            *}
{******************************************************************************************PH*}
unit untAbstractCalculadorPrecoTinta;

interface

uses
  SysUtils, untIConsultaTinta, untAutcomTintaFactory,
  untIDataSet, untICalculadorPrecoTinta, untIDigDadosTintometricos,
  untIDicionario, Classes;

type
  TAbstractCalculadorPrecoTinta = class abstract(TInterfacedObject, ICalculadorPrecoTinta)
  protected
    digDados: IDigDadosTintometricos;
  public
    constructor Create(const digDados: IDigDadosTintometricos);
  public
    function fRetornaPreco(const Sender: TObject; dicRetorno: IDicionario; const dtsCadTin: IDataSet;
      blnFaturamento, blnPermiteTab: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil; strMD5Key: String = '';
      blnSemTela: Boolean = False; strEmbPro: String = ''; strModoVenda: String = ''; strCodDil: String = ''): Boolean;

  end;

implementation

uses
  untVariantUtils, untStrUtils, untLibTintaFactory;

{ TAbstractCalculadorPrecoTinta }

constructor TAbstractCalculadorPrecoTinta.Create(const digDados: IDigDadosTintometricos);
begin
  inherited Create();
  Self.digDados := digDados;
end;

function TAbstractCalculadorPrecoTinta.fRetornaPreco(const Sender: TObject; dicRetorno: IDicionario; const dtsCadTin: IDataSet;
      blnFaturamento, blnPermiteTab: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil; strMD5Key: String = '';
      blnSemTela: Boolean = False; strEmbPro: String = ''; strModoVenda: String = ''; strCodDil: String = ''): Boolean;
var
  consulta: IConsultaTinta;
  strAuto: String;
  strTabPre: String;
  strOpcDoc: String;
  blnUsaPreCus: Boolean;
  intLazQua: Integer;
begin
  Result := False;
  Try
    Try
      strOpcDoc    := TVariantUtils.IfNull(dicRetorno['opcdoc'], '');
      blnUsaPreCus := TVariantUtils.IfNull(dicRetorno['usaprecus'], False);
      intLazQua    := TVariantUtils.IfNull(dicRetorno['lazqua'], False);

      dicRetorno['precus'] := 0.0;
      dicRetorno['unitar'] := 0.0;
      dicRetorno['fattin'] := 0.0;
      dicRetorno['prctin'] := 0.0;
      dicRetorno['prvtin'] := 0.0;
      dicRetorno['codite'] := '';
      dicRetorno['descor'] := '';
      dicRetorno['itetin'] := '';
      dicRetorno['tippre'] := '';
      dicRetorno['lazqua'] := 0;
      dicRetorno['tipemb'] := '';
      dicRetorno['qtdemb'] := 0;
      dicRetorno['preemb'] := 0.0;
      dicRetorno['embala'] := 0.0;
      dicRetorno['iteemb'] := '';
      dicRetorno['montad'] := '';
      dicRetorno['a_n_o_'] := '';
      dicRetorno['univer'] := '';
      dicRetorno['volpro'] := 0.0;
      dicRetorno['linha_'] := '';

      strTabPre := TVariantUtils.IfNull(dicRetorno['tabpre'], '');
      if TStrUtils.fEmptyStr(strTabPre) then
      begin
        strTabPre := TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString);
        if TStrUtils.fEmptyStr(strTabPre) then
        begin
          strTabPre := '1';
        end;
      end;

    {$IFDEF LINUX}
      strAuto := strAutoTab;
    {$ELSE}
      If blnSemTela Or (strTab = 'S') Then
      Begin
        strAuto := strAutoTab;
      End
      Else
      Begin
        strAuto := TAutcomTintaFactory.Get.fConsultaDinamicaVenda(Sender, strTabPre,
          TLibTintaFactory.GetLibTinta.GetITintadeMaquina, blnFaturamento, blnPermiteTab, dicRetorno, sltItems);
        If (strAuto = '-1') Then
        Begin
          Exit;
        End;
      End;
    {$ENDIF}

      consulta := TAutcomTintaFactory.Get.GetIConsultaTinta(TLibTintaFactory.GetLibTinta.GetITintadeMaquina);

      If strAuto.IsEmpty And Not strMD5Key.IsEmpty Then
      Begin
        dtsCadTin.Close;
        dtsCadTin.SQL := consulta.fGetSelectMD5KEY(strMD5Key);
        dtsCadTin.Open;
        If dtsCadTin.IsEmpty Then
          Raise Exception.Create(Format('Não existe tinta "%s" com o MD5 "%s".', [dicRetorno['idepro'], strMD5Key]));
      End
      Else
      Begin
        dtsCadTin.Close;
        dtsCadTin.SQL := consulta.fGetSelectAutoIncrem(strAuto);
        dtsCadTin.Open;
      End;


      if not digDados.fDigDadosTintometricos(dtsCadTin, dicRetorno, blnSemTela, strEmbPro, strModoVenda, strCodDil) then
      begin
        Exit;
      end;

      If digDados.TipoTinta = 'A' Then
        dicRetorno['descor'] := Trim(digDados.DescricaoCor + ' ' + consulta.fGetDescricao(dtsCadTin.FieldByName('AUTOINCREM').AsString))
      Else
        dicRetorno['descor'] := Trim(digDados.DescricaoCor + ' ' + consulta.fGetDescricao(dtsCadTin.FieldByName('AUTOINCREM').AsString, digDados.CodigoItem));

      {**********************************************************}
      {* DEVE VOLTAR A EMPRESA LOGADA NOVAMENTE NA DLL DA TINTA *}
      {******************************************************RG**}

      TAutcomTintaFactory.Get.pSetaEmpresaLogadaTinta(dicRetorno['codemp']);

      dicRetorno['itetin'] := digDados.ChaveIteTin;
      dicRetorno['unidad'] := digDados.Unidade;

      dicRetorno['precus'] := digDados.PrecoCustoTinta;

      if blnUsaPreCus then
        dicRetorno['unitar'] := digDados.PrecoCustoTinta
      else
        dicRetorno['unitar'] := digDados.PrecoVendaTinta;

      if strOpcDoc = 'BR' then
        dicRetorno['unitar'] := dicRetorno['unitar'];

      dicRetorno['prvtin'] := dicRetorno['unitar'];

      dicRetorno['codite'] := digDados.CodigoItem;

      dicRetorno['desopetinta'] := TAutcomTintaFactory.Get.fGetConfTinta(dicRetorno['idepro']).fGetDouble('DESOPE');

      dicRetorno['fattin'] := digDados.FatorTinta;
      dicRetorno['iteemb'] := digDados.ItemEmbalagem;
      dicRetorno['tippre'] := digDados.TipoPreco;
      dicRetorno['lazqua'] := intLazQua;
      dicRetorno['tipemb'] := digDados.TipoEmbalagem;
      dicRetorno['qtdemb'] := digDados.QuantidadeEmbalagem;
      dicRetorno['preemb'] := digDados.PrecoEmbalagem;
      dicRetorno['embala'] := digDados.Embalagem;
      dicRetorno['itecha'] := digDados.ItemChapinha;
      dicRetorno['usacha'] := digDados.UsaChapinha;
      dicRetorno['volpro'] := digDados.VolumeProduto;

      dicRetorno['montad'] := digDados.Montadadora;
      dicRetorno['a_n_o_'] := digDados.A_n_o_;
      dicRetorno['univer'] := digDados.Universal;
      dicRetorno['chafor'] := digDados.ChaFor;

      dicRetorno['catali'] := digDados.Catalisador;

      dicRetorno['baseqtdzerada'] := digDados.BaseQtdZerada;

      dicRetorno['linha_'] := digDados.Linha;

      dicRetorno['chafor'] := digDados.GetChaForEspecifico(dicRetorno, dtsCadTin);

      Result := True;
    Except
      on E: Exception do
      begin
       {$IFDEF LINUX}TAutcomTintaFactory.Get().WriteError(E.Message);{$ELSE}raise;{$ENDIF}
      end;
    End;
  Finally

  End;                            
end;

end.
