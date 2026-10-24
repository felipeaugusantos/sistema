unit Produto.GS1CNP.Consulta.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxClasses, cxGridLevel, cxGrid, cxCheckBox, untFuncoesSimples,
  cxDataControllerConditionalFormattingRulesManagerDialog, untFuncoesGenerica,
  System.UITypes;

type

  TProdutoGS1CNPConsultaView = class(TfrmPaiConfirma)
    pnlStatusCadastro: TPanel;
    grdDadosConsulta: TcxGrid;
    grdDadosConsultaTableView: TcxGridTableView;
    grdDadosConsultaTableViewCampo: TcxGridColumn;
    grdDadosConsultaTableViewValorCadCli: TcxGridColumn;
    grdDadosConsultaTableViewValor: TcxGridColumn;
    grdDadosConsultaTableViewTrocar: TcxGridColumn;
    grdDadosConsultaLevel: TcxGridLevel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdDadosConsultaTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure grdDadosConsultaTableViewTrocarPropertiesChange(Sender: TObject);
  private
    FResultado: TDicionario;
    FConfirma: Boolean;
    FValoresAtuais: TDicionario;
    FCodBar: String;
    FInsert: Boolean;
    FAccessToken: String;
    procedure pExecConsulta();

    procedure pExecConsultaGS1CNP();
    function GetResultado: TDicionario;
    procedure pAddInfo(strCampo, strValorCadCli, strValor: String; blnMarcar: Boolean = True);
    function RetornaCorStatus(const AValue: String): TColor;
    function RetornaCaptionStatus(const AValue: String): String;
  public
    property dicValoresAtuais: TDicionario read FValoresAtuais;
    property dicResultado: TDicionario read GetResultado;
    property blnConfirma: Boolean read FConfirma;
    property strCodBar: String write FCodBar;
    property blnInsert: Boolean write FInsert;
    property strAccessToken: String write FAccessToken;
  end;

var
  ProdutoGS1CNPConsultaView: TProdutoGS1CNPConsultaView;

implementation

{$R *.dfm}

uses untGravando, Produto.GS1CNP.Interfaces.Consulta, Produto.GS1CNP.Interfaces.Service,
  Produto.GS1CNP.Service.Consulta, Produto.GS1CNP.Shared.Exception,
  Produto.GS1CNP.Shared.Constants;

{ TProdutoGS1CNPConsultaView }

procedure TProdutoGS1CNPConsultaView.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  FConfirma := True;
end;

procedure TProdutoGS1CNPConsultaView.FormCreate(Sender: TObject);
begin
  inherited;
  FConfirma          := False;
  FResultado         := TDicionario.Create;
  FValoresAtuais     := TDicionario.Create;
  pnlInfo.Font.Color := clRed;
  pnlInfo.Caption    := 'Dados em vermelho indicam divergência entre informações consultadas e Cad.Produtos.';
end;

procedure TProdutoGS1CNPConsultaView.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FResultado);
  FreeAndNil(FValoresAtuais);
end;

procedure TProdutoGS1CNPConsultaView.FormShow(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pExecConsulta, 'Realizando consulta...', '');
end;

function TProdutoGS1CNPConsultaView.GetResultado: TDicionario;
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

procedure TProdutoGS1CNPConsultaView.grdDadosConsultaTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strChave: String;
  varValorAtual, varValorNovo: Variant;
begin
  inherited;

  if AViewInfo.Item.Index = grdDadosConsultaTableViewValor.Index then
  begin

    strChave := AViewInfo.GridRecord.Values[grdDadosConsultaTableViewCampo.Index];

    varValorAtual := FValoresAtuais.Retorna(strChave);
    varValorNovo  := AViewInfo.GridRecord.Values[grdDadosConsultaTableViewValor.Index];

//    if strChave = DESC_CEP then
//      varValorNovo := fTiraCaracEspeciaisPonto(varValorNovo);
//
//    if strChave = DESC_CNPJ then
//      varValorNovo := fTiraCaracEspeciaisPonto(varValorNovo);

    if varValorAtual <> varValorNovo then
      ACanvas.Font.Color := clRed;
  end;
end;

procedure TProdutoGS1CNPConsultaView.grdDadosConsultaTableViewTrocarPropertiesChange(
  Sender: TObject);
var
  intCount: Integer;
  strNome: String;
begin
  inherited;

//  If Not (grdDadosConsultaTableViewCampo.GridView.ViewInfo.GridView.gr DataController.GetValue() = PROD_IMAGEM) Then
//    Exit;

//  If Not (grdDadosConsultaTableViewCampo.ToString = PROD_IMAGEM) Then
//    Exit;

//  with grdDadosConsultaTableView.DataController do
//  begin
//    for intCount := 0 to Pred(GetSelectedCount) do
//    begin
//      ARowIndex := GetSelectedRowIndex(i); // retorna o índice da linha selecionada
//      ARowInfo  := GetRowInfo(ARowIndex); // retorna informação da linha selecionada
//      DeleteRecord(ARowInfo.RecordIndex); // deleta o registro da linha selecionada
//    end;
//  end;

  intCount := grdDadosConsultaTableView.DataController.GetEditingRecordIndex;

  strNome := grdDadosConsultaTableView.DataController.Values[intCount, 0];

  If strNome <> PROD_IMAGEM Then
    Exit;

  If Not FInsert Then
    Exit;

  fMensagem('Atenção','Para atualizar a imagem é preciso ter gerado o código para o cadastro do produto. ' + #13#10 + 'Portanto, gravar o cadastro e depois editá-lo', ['&Ok']);
  grdDadosConsultaTableView.DataController.Cancel;
end;

procedure TProdutoGS1CNPConsultaView.pAddInfo(strCampo, strValorCadCli, strValor: String; blnMarcar: Boolean = True);
var
  intRec: Integer;
begin
  intRec := grdDadosConsultaTableView.DataController.AppendRecord;
  grdDadosConsultaTableView.DataController.Values[intRec, 0] := strCampo;
  grdDadosConsultaTableView.DataController.Values[intRec, 1] := strValorCadCli;
  grdDadosConsultaTableView.DataController.Values[intRec, 2] := strValor;
  grdDadosConsultaTableView.DataController.Values[intRec, 3] := not fEmptyStr(strValor) And blnMarcar;
  grdDadosConsultaTableView.DataController.Post();
end;

procedure TProdutoGS1CNPConsultaView.pExecConsulta;
begin
  pExecConsultaGS1CNP();
end;

procedure TProdutoGS1CNPConsultaView.pExecConsultaGS1CNP;
var
  LProdutoGS1CNPService: IProdutoGS1CNPServiceConsulta;
  LRetorno: IProdutoGS1CNPConsultaRetorno;
begin
  LProdutoGS1CNPService := TProdutoGS1CNPServiceConsulta.New(FAccessToken);
  LRetorno := Nil;

  try
    try
      LRetorno := LProdutoGS1CNPService.Consultar(FCodBar);

      pAddInfo(PROD_DESCRICAO ,    dicValoresAtuais.retorna(dicValoresAtuais.chaves[0]), LRetorno.GetDescricao);
      pAddInfo(PROD_MARCA     ,    dicValoresAtuais.retorna(dicValoresAtuais.chaves[1]), LRetorno.GetMarca);
      pAddInfo(PROD_PESO_BRUTO,    dicValoresAtuais.retorna(dicValoresAtuais.chaves[2]), FloatToStr(LRetorno.GetPesoBruto));
      pAddInfo(PROD_PESO_LIQUIDO,  dicValoresAtuais.retorna(dicValoresAtuais.chaves[3]), FloatToStr(LRetorno.GetPesoLiquido));
      pAddInfo(PROD_CODIGO_GPC,    dicValoresAtuais.retorna(dicValoresAtuais.chaves[4]), LRetorno.GetCodigoGPC);
      pAddInfo(PROD_IMAGEM,        dicValoresAtuais.retorna(dicValoresAtuais.chaves[5]), LRetorno.GetImagem, Not FInsert);
      pAddInfo(PROD_NCM,           dicValoresAtuais.retorna(dicValoresAtuais.chaves[6]), LRetorno.GetNcm);

      pnlStatusCadastro.Visible    := True;
      pnlStatusCadastro.Font.Color := RetornaCorStatus(LRetorno.GetStatus);
      pnlStatusCadastro.Caption    := RetornaCaptionStatus(LRetorno.GetStatus);
    except
      on e: ErroConsultaView do
      begin
        fMensagem('Erro', e.Message, ['&Ok']);
        blnFecharFormPai := True;
      end;
    end;
  finally

  end;
end;

function TProdutoGS1CNPConsultaView.RetornaCaptionStatus(
  const AValue: String): String;
begin
  Result := 'Ativo';

  If (AValue = STATUS_GTIN_ACTIVE) Then
    Exit;

  Result := 'Inativo';
end;

function TProdutoGS1CNPConsultaView.RetornaCorStatus(
  const AValue: String): TColor;
begin
  Result := clGreen;

  If (AValue = STATUS_GTIN_ACTIVE) Then
    Exit;

  Result := clRed;
end;

end.
