{*********************************************************************************************}
{* Classe abstrata que implementa a interface ICalculadorPrecoTinta responsável pelo calculo *}
{* de preço da tinta ao todo, retornando os valores para o Autcom                            *}
{******************************************************************************************PH*}
unit untAbstractCalculadorPrecoTinta;

interface

uses
  SysUtils, untIConsultaTinta, untAutcomTintaFactory,
  untIDataSet, untICalculadorPrecoTinta, untIDigDadosTintometricos,
  untIDicionario;

type
  TAbstractCalculadorPrecoTinta = class abstract(TInterfacedObject, ICalculadorPrecoTinta)
  protected
    digDados: IDigDadosTintometricos;
  public
    constructor Create(const digDados: IDigDadosTintometricos);
  public
    function fRetornaPreco(const Sender: TObject; const dicRetorno: IDicionario; const dtsCadTin: IDataSet): Boolean;

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

function TAbstractCalculadorPrecoTinta.fRetornaPreco(const Sender: TObject; const dicRetorno: IDicionario; const dtsCadTin: IDataSet): Boolean;
var
  consulta: IConsultaTinta;
  strAuto: String;
  strTabPre: String;
  strOpcDoc: String;
  blnUsaPreCus: Boolean;
begin
  Result := False;
  Try
    Try
      strOpcDoc    := TVariantUtils.IfNull(dicRetorno['opcdoc'], '');
      blnUsaPreCus := TVariantUtils.IfNull(dicRetorno['usaprecus'], False);

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

      strTabPre := TVariantUtils.IfNull(dicRetorno['tabpre'], '');
      if TStrUtils.fEmptyStr(strTabPre) then
      begin
        strTabPre := TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString);
        if TStrUtils.fEmptyStr(strTabPre) then
        begin
          strTabPre := '1';
        end;
      end;

      strAuto := TAutcomTintaFactory.Get.fConsultaDinamicaVenda(Sender, strTabPre,
        TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
      If (strAuto = '-1') Then
      Begin
        Exit;
      End;

      consulta := TAutcomTintaFactory.Get.GetIConsultaTinta(TLibTintaFactory.GetLibTinta.GetITintadeMaquina);

      dtsCadTin.Close;
      dtsCadTin.SQL := consulta.fGetSelectAutoIncrem(strAuto);
      dtsCadTin.Open;

      if not digDados.fDigDadosTintometricos(dtsCadTin, dicRetorno) then
      begin
        Exit;
      end;

      dicRetorno['descor'] := Trim(digDados.DescricaoCor + ' ' +
        consulta.fGetDescricao(dtsCadTin.FieldByName('AUTOINCREM').AsString, digDados.CodigoItem));

      dicRetorno['itetin'] := digDados.ChaveIteTin;
      dicRetorno['unidad'] := digDados.Unidade;

      dicRetorno['precus'] := digDados.PrecoCustoTinta;

      if blnUsaPreCus then
        dicRetorno['unitar'] := digDados.PrecoCustoTinta
      else
        dicRetorno['unitar'] := digDados.PrecoVendaTinta;

      if strOpcDoc = 'BR' then
        dicRetorno['unitar'] := digDados.PrecoVendaTinta;

      dicRetorno['prvtin'] := digDados.PrecoVendaTinta;
      dicRetorno['prctin'] := digDados.PrecoCustoTinta;
      dicRetorno['codite'] := digDados.CodigoItem;

      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

end.
