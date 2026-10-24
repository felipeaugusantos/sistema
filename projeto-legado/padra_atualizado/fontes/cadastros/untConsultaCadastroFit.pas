unit untConsultaCadastroFit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxClasses, cxGridLevel, cxGrid, cxCheckBox, untFuncoesSimples, StrUtils, untDiarioToolsCitelDevCnpj,
  cxDataControllerConditionalFormattingRulesManagerDialog, untFuncoesGenerica,
  VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes,
  VCL.TMSFNCCustomControl, VCL.TMSFNCWebBrowser, untInterfaces;

type

  TfrmConsultaCadastroFit = class(TfrmPaiConfirma)
    grdDadosConsultaLevel: TcxGridLevel;
    grdDadosConsulta: TcxGrid;
    grdDadosConsultaTableView: TcxGridTableView;
    grdDadosConsultaTableViewCampo: TcxGridColumn;
    grdDadosConsultaTableViewValor: TcxGridColumn;
    grdDadosConsultaTableViewTrocar: TcxGridColumn;
    pnlStatusCadastro: TPanel;
    grdDadosConsultaTableViewValorCadCli: TcxGridColumn;
    browser: TTMSFNCWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure grdDadosConsultaTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    FResultado: TDicionario;
    FCnpj: String;
    FConfirma: Boolean;
    FValoresAtuais: TDicionario;
    FMostraCnae: Boolean;
    FOrigem: String;
    FTemDivergencia: Boolean;
    procedure pExecConsultaCnpj;
    function GetResultado: TDicionario;
    procedure pAddInfo(strCampo, strValorCadCli, strValor: String);
    procedure pAdicionaCampo(strCampo: String; intIndexChave: Integer;
      strValor: String);
    procedure pSetarResultadoConsulta(DiarioToolsCitelDevCnpj : TDiarioToolsCitelDevCnpj);
  public
    property strCnpj: String read FCnpj write FCnpj;
    property dicValoresAtuais: TDicionario read FValoresAtuais;
    property dicResultado: TDicionario read GetResultado;
    property blnConfirma: Boolean read FConfirma;
    property blnMostraCnae: Boolean read FMostraCnae write FMostraCnae;
    property strOrigem: String read FOrigem write FOrigem;
    property blnTemDivergencia: Boolean read FTemDivergencia write FTemDivergencia;
    procedure pExecConsulta();
  end;

var
  frmConsultaCadastroFit: TfrmConsultaCadastroFit;

implementation

{$R *.dfm}

uses untLibNfe, untIConsultaCadastroFit;

{ TfrmConsultaCadastroFit }

procedure TfrmConsultaCadastroFit.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  FConfirma := True;
end;

procedure TfrmConsultaCadastroFit.FormCreate(Sender: TObject);
begin
  inherited;
  FConfirma := False;
  FResultado := TDicionario.Create;
  FValoresAtuais := TDicionario.Create;
  pnlInfo.Font.Color := clRed;
  pnlInfo.Caption := 'Dados em vermelho indicam divergência entre informações consultadas e Cad.Clientes.';
  FOrigem := EmptyStr;
  FTemDivergencia := False;
  browser.Visible := False;
end;

procedure TfrmConsultaCadastroFit.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FResultado);
  FreeAndNil(FValoresAtuais);
end;

function TfrmConsultaCadastroFit.GetResultado: TDicionario;
var
  intIdx: Integer;
begin
  FResultado.Limpar;
  for intIdx := 0 to grdDadosConsultaTableView.DataController.RecordCount - 1 do
  begin
    if grdDadosConsultaTableView.DataController.Values[intIdx, 3] then
    begin
      FResultado.Adicionar(grdDadosConsultaTableView.DataController.Values[intIdx, 0],
                           grdDadosConsultaTableView.DataController.Values[intIdx, 2]);
    end;
  end;
  Result := FResultado;
end;

procedure TfrmConsultaCadastroFit.grdDadosConsultaTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strChave: String;
  varValorAtual, varValorNovo: Variant;
  clrCorAtual: TColor;
  varValEndereco: Variant;
begin
  inherited;
  if AViewInfo.Item.Index = grdDadosConsultaTableViewValor.Index then
  begin
    strChave := AViewInfo.GridRecord.Values[grdDadosConsultaTableViewCampo.Index];
    varValorAtual := FValoresAtuais.Retorna(strChave);
    varValorNovo  := AViewInfo.GridRecord.Values[grdDadosConsultaTableViewValor.Index];
    varValEndereco :=  FValoresAtuais.Retorna(DESC_ENDERECO);
    if strChave = DESC_CEP then
      varValorNovo := fTiraCaracEspeciaisPonto(varValorNovo);
    if strChave = DESC_CNPJ then
      varValorNovo := fTiraCaracEspeciaisPonto(varValorNovo);
    if varValorAtual <> varValorNovo then
    begin
      clrCorAtual := ACanvas.Font.Color;
      ACanvas.Font.Color := clRed;

      //Caso a origem seja do cadastro de transportadora é feita a função abaixo.
      //Como no cadastro de transportadora o endereço é concatenado com o número e complemento
      //o grid sempre traria esses três campos em vermelho mesmo sendo iguais já que o sefaz trás esses campos separados.
      if FOrigem = 'untCadTransportadoras' then
      begin
        case AnsiIndexStr(strChave, [DESC_ENDERECO, DESC_NUMERO]) of
          0, 1: if VarToStrDef(varValEndereco, EmptyStr).Contains(VarToStrDef(varValorNovo, EmptyStr)) then
               ACanvas.Font.Color := clrCorAtual;
        end;
      end;

      if MatchStr(strChave, [DESC_SIT_SIMPLES, DESC_SIT_SIMEI]) then
        ACanvas.Font.Color := clrCorAtual;

      if ACanvas.Font.Color = clRed then
        FTemDivergencia := True;
    end;
  end;
end;

procedure TfrmConsultaCadastroFit.pAddInfo(strCampo, strValorCadCli, strValor: String);
var
  intRec: Integer;
begin
  intRec := grdDadosConsultaTableView.DataController.AppendRecord;
  grdDadosConsultaTableView.DataController.Values[intRec, 0] := strCampo;
  grdDadosConsultaTableView.DataController.Values[intRec, 1] := strValorCadCli;
  grdDadosConsultaTableView.DataController.Values[intRec, 2] := strValor;
  grdDadosConsultaTableView.DataController.Values[intRec, 3] := not fEmptyStr(strValor);
  grdDadosConsultaTableView.DataController.Post();
end;

procedure TfrmConsultaCadastroFit.pExecConsulta;
begin
  pExecConsultaCnpj;
end;

procedure TfrmConsultaCadastroFit.pAdicionaCampo(strCampo: String; intIndexChave: Integer;
  strValor: String);
  Var
    strValorCadCli: String;
begin
  If (dicValoresAtuais.chaves.Count <= intIndexChave) Then
    Exit;

  strValorCadCli := dicValoresAtuais.retorna(dicValoresAtuais.chaves[intIndexChave]);

  If (strCampo.Equals(DESC_CNPJ)) Then
    strValorCadCli := fFormataCpfCgc(strValorCadCli, opcBrasil);

  pAddInfo(strCampo, strValorCadCli, strValor);
end;

procedure TfrmConsultaCadastroFit.pExecConsultaCnpj;
var
  DiarioToolsCitelDevCnpj: TDiarioToolsCitelDevCnpj;
begin
  DiarioToolsCitelDevCnpj := TDiarioToolsCitelDevCnpj.fDiarioToolsConsultaCnpj(fTiraCaracEspeciaisPonto(FCnpj));
  try
    if not Assigned(DiarioToolsCitelDevCnpj) then
    begin
      fMensagem('ATENÇÃO', 'Não foi possível consultar o CNPJ. Tente novamente!', ['&Ok']);
      Exit;
    end;

    pSetarResultadoConsulta(DiarioToolsCitelDevCnpj);
  finally
    if Assigned(DiarioToolsCitelDevCnpj) then
      FreeAndNil(DiarioToolsCitelDevCnpj);
  end;
end;

procedure TfrmConsultaCadastroFit.pSetarResultadoConsulta(DiarioToolsCitelDevCnpj: TDiarioToolsCitelDevCnpj);
begin
  pAdicionaCampo(DESC_RAZAO_SOCIAL,  0, DiarioToolsCitelDevCnpj.empresa.razao_social);
  pAdicionaCampo(DESC_NOME_FANTASIA, 1, DiarioToolsCitelDevCnpj.empresa.nome_fantasia);
  pAdicionaCampo(DESC_INSC_EST,      2, DiarioToolsCitelDevCnpj.empresa.inscricao_estadual.ie);
  pAdicionaCampo(DESC_ENDERECO,      3, DiarioToolsCitelDevCnpj.empresa.endereco.logradouro);
  pAdicionaCampo(DESC_NUMERO,        4, DiarioToolsCitelDevCnpj.empresa.endereco.numero);
  pAdicionaCampo(DESC_COMPLEMENTO,   5, DiarioToolsCitelDevCnpj.empresa.endereco.complemento);
  pAdicionaCampo(DESC_BAIRRO,        6, DiarioToolsCitelDevCnpj.empresa.endereco.bairro);
  pAdicionaCampo(DESC_CEP,           7, DiarioToolsCitelDevCnpj.empresa.endereco.cep);
  pAdicionaCampo(DESC_IBGE_CIDADE,   8, DiarioToolsCitelDevCnpj.empresa.endereco.codigo_ibge);
  pAdicionaCampo(DESC_CNPJ,          9, DiarioToolsCitelDevCnpj.empresa.cnpj_formatado);

  If (FMostraCnae) Then
    pAdicionaCampo(DESC_CNAE, 10, fStrZero(DiarioToolsCitelDevCnpj.empresa.cnae_principal.codigo, 7));

  pAdicionaCampo(DESC_DATA_ABERTURA, 11, DateToStr(DiarioToolsCitelDevCnpj.empresa.data_abertura));

  pAddInfo(DESC_SIT_SIMPLES, '', IIF(DiarioToolsCitelDevCnpj.empresa.simples.optante, 'OPTANTE DESDE ' + DiarioToolsCitelDevCnpj.empresa.simples.data_opcao, 'NÃO OPTANTE'));
  pAddInfo(DESC_SIT_SIMEI, '', IIF(DiarioToolsCitelDevCnpj.empresa.simei.optante, 'OPTANTE DESDE ' + DiarioToolsCitelDevCnpj.empresa.simei.data_opcao, 'NÃO OPTANTE'));

  pnlStatusCadastro.Visible := True;
  pnlStatusCadastro.Caption := 'Situação: ' + DiarioToolsCitelDevCnpj.empresa.situacao_cadastral.situacao;
  if DiarioToolsCitelDevCnpj.empresa.situacao_cadastral.situacao.ToUpper <> 'ATIVA' then
    pnlStatusCadastro.Font.Color := clRed
  else
    pnlStatusCadastro.Font.Color := clGreen;
End;

end.


