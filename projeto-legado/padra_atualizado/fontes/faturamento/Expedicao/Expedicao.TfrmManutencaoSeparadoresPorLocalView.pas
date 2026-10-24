unit Expedicao.TfrmManutencaoSeparadoresPorLocalView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGridCitel, cxGrid,
  Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem,
  untZClient, cxDBLookupComboBox, uni, System.UITypes, EditFocus,

  Expedicao.TManutencaoSeparadoresPorLocal;

type
  TTfrmManutencaoSeparadoresPorLocalView = class(TfrmPaiConfirma)
    cxgLocaisSeparacaoTBV: TcxGridDBTableViewCitel;
    cxgLocaisSeparacaoLVL: TcxGridLevel;
    cxgLocaisSeparacao: TcxGridCitel;
    cxgItensLVL: TcxGridLevel;
    cxgItensTBV: TcxGridDBTableViewCitel;
    cxgLocaisSeparacaoLOCAL_SEPARACAO: TcxGridDBColumn;
    cxgLocaisSeparacaoSEPARADOR_ATUAL: TcxGridDBColumn;
    cxgLocaisSeparacaoDESCRICAO_SEPARADOR_NOVO: TcxGridDBColumn;
    cxgItensCODIGO_PRODUTO: TcxGridDBColumn;
    cxgItensDESCRICAO_PRODUTO: TcxGridDBColumn;
    cxgItensLOCALIZACAO_FISICA: TcxGridDBColumn;
    cxgItensQUANTIDADE: TcxGridDBColumn;
    cxgLocaisSeparacaoSEPARACAO_INICIADA: TcxGridDBColumn;
    pnlLegenda: TPanel;
    shpSeparacaoIniciada: TShape;
    Label3: TLabel;
    pnlDados: TPanel;
    Label1: TLabel;
    edtPedido: TEditFocus;
    btnAlterar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgLocaisSeparacaoTBVCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
  private
    cdsLocaisSeparacao : TZClient;
    cdsItens: TZClient;
    qryUpdate : TUniQuery;
    objManutencaoSeparadoresPorLocal : TManutencaoSeparadoresPorLocal;

    procedure pAtualizaSeparador(strAutoincremFATGOR, strCodigoLocalSeparacao, strCodigoSeparadorNovo: String);
    { Private declarations }
  public
    strAutoincremFATGOR : String;
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, Expedicao.TManutencaoSeparadoresPorLocalConstantes, untDigOperador;

{$R *.dfm}

procedure TTfrmManutencaoSeparadoresPorLocalView.btnAlterarClick(Sender: TObject);
var
  strSeparador : String;

begin
  if not objManutencaoSeparadoresPorLocal.fPermiteAlterarSeparador( cdsLocaisSeparacao.FieldByName( TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARACAO_INICIADA ).AsString ) then
  begin
    pMensagemOk('A separação do local '+ cdsLocaisSeparacao.FieldByName( TManutencaoSeparadoresPorLocalConstantes.CAMPO_LOCAL_SEPARACAO ).AsString +' já foi iniciada e o separador não pode ser alterado!');
    exit();
  end;

  If fCfgSis('SENSEP', varString) = 'S' Then
  begin
    If ffrmSenha(strSeparador, 'Informe a senha do separador') Then
      strSeparador := fRetCodVendedor(strSeparador);
  end
  Else
    strSeparador := TfrmDigOperador.fGetCodOperador( '', 'Informe o código do separador' );

  If not fEmptyStr(strSeparador) Then
  Begin
    cdsLocaisSeparacao.Edit;
    cdsLocaisSeparacao.FieldByName( TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARADOR_NOVO ).AsString := strSeparador;
    cdsLocaisSeparacao.FieldByName( TManutencaoSeparadoresPorLocalConstantes.CAMPO_DESCRICAO_SEPARADOR_NOVO ).AsString := strSeparador + '-' + fRetNomeOperador(strSeparador);
    cdsLocaisSeparacao.Post;
  End;

end;

procedure TTfrmManutencaoSeparadoresPorLocalView.btnConfirmaClick(Sender: TObject);
var
  intOpcao : integer;
begin
  intOpcao := fMensagem('','Confirma a atualização dos separadores?', ['&Sim', '&Não', '&Cancela']);

  if intOpcao = 3 then
  begin
    ModalResult := mrNone;
    exit();
  end;

  if intOpcao = 1 then
    objManutencaoSeparadoresPorLocal.pAtualizaSeparadores(strAutoincremFATGOR, pAtualizaSeparador);
end;

procedure TTfrmManutencaoSeparadoresPorLocalView.pAtualizaSeparador(strAutoincremFATGOR, strCodigoLocalSeparacao, strCodigoSeparadorNovo : String);
begin
  qryUpdate.ParamByName( TManutencaoSeparadoresPorLocalConstantes.PARAMETRO_AUTOINCREM_FATGOR ).AsString      := strAutoincremFATGOR;
  qryUpdate.ParamByName( TManutencaoSeparadoresPorLocalConstantes.PARAMETRO_CODIGO_LOCAL_SEPARACAO ).AsString := strCodigoLocalSeparacao;
  qryUpdate.ParamByName( TManutencaoSeparadoresPorLocalConstantes.PARAMETRO_CODIGO_SEPARADOR_NOVO ).AsString  := strCodigoSeparadorNovo;

  qryUpdate.ExecSQL;
end;

procedure TTfrmManutencaoSeparadoresPorLocalView.cxgLocaisSeparacaoTBVCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if not objManutencaoSeparadoresPorLocal.fPermiteAlterarSeparador(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgLocaisSeparacaoSEPARACAO_INICIADA.Index]) )then
    ACanvas.Brush.Color := TManutencaoSeparadoresPorLocalConstantes.COR_SEPARACAO_INICIADA ;
end;

procedure TTfrmManutencaoSeparadoresPorLocalView.FormCreate(Sender: TObject);
begin
  inherited;

  objManutencaoSeparadoresPorLocal := TManutencaoSeparadoresPorLocal.Create( fCfgSis('LSEWMS', varBoolean) );

  cdsLocaisSeparacao := TZClient.Create( Self, objManutencaoSeparadoresPorLocal.objSQLSeparadorLocalSeparacao.fRetornaSQLLocaisSeparacao( VS_strCodEmp ) );
  cxgLocaisSeparacaoTBV.DataController.DataSource := cdsLocaisSeparacao.dtsSource;

  cdsItens := TZClient.Create( Self, objManutencaoSeparadoresPorLocal.objSQLSeparadorLocalSeparacao.fRetornaSQLItens( VS_strCodEmp ) );
  cxgItensTBV.DataController.DataSource := cdsItens.dtsSource;

  qryUpdate := fCriaQuery( Self );
  qryUpdate.SQL.Text := objManutencaoSeparadoresPorLocal.objSQLSeparadorLocalSeparacao.fRetornaSQLUpdateLocalSeparacao( VS_strCodEmp );

  objManutencaoSeparadoresPorLocal.dtsLocais := cdsLocaisSeparacao;
  shpSeparacaoIniciada.Brush.Color := TManutencaoSeparadoresPorLocalConstantes.COR_SEPARACAO_INICIADA;

  cxgLocaisSeparacaoLOCAL_SEPARACAO.DataBinding.FieldName    := TManutencaoSeparadoresPorLocalConstantes.CAMPO_LOCAL_SEPARACAO;
  cxgLocaisSeparacaoSEPARADOR_ATUAL.DataBinding.FieldName    := TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARADOR_ATUAL;
  cxgLocaisSeparacaoDESCRICAO_SEPARADOR_NOVO.DataBinding.FieldName     := TManutencaoSeparadoresPorLocalConstantes.CAMPO_DESCRICAO_SEPARADOR_NOVO;
  cxgLocaisSeparacaoSEPARACAO_INICIADA.DataBinding.FieldName := TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARACAO_INICIADA;


  cxgItensCODIGO_PRODUTO.DataBinding.FieldName     := TManutencaoSeparadoresPorLocalConstantes.CAMPO_CODIGO_PRODUTO;
  cxgItensDESCRICAO_PRODUTO.DataBinding.FieldName  := TManutencaoSeparadoresPorLocalConstantes.CAMPO_DESCRICAO_PRODUTO;
  cxgItensLOCALIZACAO_FISICA.DataBinding.FieldName := TManutencaoSeparadoresPorLocalConstantes.CAMPO_LOCALIZACAO_FISICA;
  cxgItensQUANTIDADE.DataBinding.FieldName         := TManutencaoSeparadoresPorLocalConstantes.CAMPO_QUANTIDADE;

end;

procedure TTfrmManutencaoSeparadoresPorLocalView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_F2 then
    btnAlterarClick(btnAlterar);
end;

procedure TTfrmManutencaoSeparadoresPorLocalView.FormShow(Sender: TObject);
begin
  inherited;
  edtPedido.Text := fCampoTabela('CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP)', 'FATGOR', ['AUTOINCREM'], [strAutoincremFATGOR]);

  cdsLocaisSeparacao.qryQuery.ParamByName( TManutencaoSeparadoresPorLocalConstantes.PARAMETRO_AUTOINCREM_FATGOR ).AsString := strAutoincremFATGOR;
  cdsLocaisSeparacao.fAbreClient(True);

  cdsItens.qryQuery.ParamByName( TManutencaoSeparadoresPorLocalConstantes.PARAMETRO_AUTOINCREM_FATGOR ).AsString := strAutoincremFATGOR;
  cdsItens.fAbreClient(True);

  cxgLocaisSeparacaoTBV.ViewData.Expand(True);
end;




end.
