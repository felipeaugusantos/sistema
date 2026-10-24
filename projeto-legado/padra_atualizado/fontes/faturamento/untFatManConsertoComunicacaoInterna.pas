unit untFatManConsertoComunicacaoInterna;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Menus, Buttons, ExtCtrls, AppEvnts, MemoFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, untConsertoEquipamento, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, Uni, untFuncoesSimples, Vcl.ComCtrls,
  cxRichEdit, StrUtils, untConstantes, cxMemo, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.DBCtrls,
  DBMemoFocus, cxContainer, cxTextEdit, cxDBEdit, untLiberacao, untFuncoesRel;

type
  TfrmFatManConsertoComunicacaoInterna = class(TfrmPai)
    pnlFundo          : TPanel;
    dtsMsg            : TDataSource;
    pnlFundoMsg       : TPanel;
    cxgConsulta       : TcxGrid;
    cxgConsultaTable  : TcxGridDBTableView;
    cxgConsultaObs    : TcxGridDBColumn;
    cxgConsultaData   : TcxGridDBColumn;
    cxgConsultaHora   : TcxGridDBColumn;
    cxgConsultaLevel1 : TcxGridLevel;
    cxStyleRepositorio: TcxStyleRepository;
    cxStyleGroup      : TcxStyle;
    cxStyleHora       : TcxStyle;
    cxStyleSelecao    : TcxStyle;
    pnlButtons        : TPanel;
    btnFechar         : TBitBtnLocked;
    lblIniOrc         : TLabel;
    lblFinOrc         : TLabel;
    lblIniMan         : TLabel;
    lblFinMan         : TLabel;
    FlowPanel1: TFlowPanel;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    cxgConsultaOperador: TcxGridDBColumn;
    memMsg: TcxDBMemo;
    btnImprimir: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dtsMsgStateChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    FQryMsg   : TUniQuery;
    FObjLiberacao: TLiberacao;
    FObjConEqu: TConEqu;

    procedure pCarregaObs;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pBeforePost(DataSet: TDataSet);
    procedure pGetTextOperador(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure pGetTextHora(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure pAtualizaBotoes;
  public
    { Public declarations }
    property ObjConEqu: TConEqu read FObjConEqu write FObjConEqu;
  end;

implementation

{$R *.dfm}

procedure TfrmFatManConsertoComunicacaoInterna.btnAlterarClick(Sender: TObject);
begin
  inherited;
  if FQryMsg.FieldByName('EQC_CODOPE').AsString <> strLoginUsuarioLogado then
  begin
    fMensagem('', 'Atenção! Não é permitido alterar registros de outros operadores.' , ['&Ok']);
    Exit;
  end;

  FObjLiberacao.Clear;
  FObjLiberacao.objMsgLibera.pAddTexto('Manutenção de Ordem de Serviços - Alterar registro de comunicação interna');
  FObjLiberacao.objMsgLibera.pAddSeparador(75);
  FObjLiberacao.objMsgLibera.pAddTextoCaption('Ordem de Serviço:', objConEqu.strNumero                                                    , 18);
  FObjLiberacao.objMsgLibera.pAddTextoCaption('Cliente:'         , objConEqu.strCodCli + ' - ' + fRetNomCliente(objConEqu.strCodCli)      , 18);
  FObjLiberacao.objMsgLibera.pAddTextoCaption('Operador:'        , strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado), 18);

  FObjLiberacao.strDirAce := 'ALTCOMINT';
  FObjLiberacao.strMsgSen := 'Alterar registro de comunicação interna';
  FObjLiberacao.strCodOpe := strLoginUsuarioLogado;
  FObjLiberacao.strCpfCnpj := objConEqu.strCliCgc;

  If Not FObjLiberacao.fLibera Then
    Exit;

  FQryMsg.Edit;
  pSetFocus(memMsg);
end;

procedure TfrmFatManConsertoComunicacaoInterna.btnCancelaClick(Sender: TObject);
begin
  inherited;
  FQryMsg.Cancel;
end;

procedure TfrmFatManConsertoComunicacaoInterna.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if FQryMsg.IsEmpty then
    Exit;

  if not (fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1) then
    Exit;

  if FQryMsg.FieldByName('EQC_CODOPE').AsString <> strLoginUsuarioLogado then
  begin
    fMensagem('', 'Atenção! Não é permitido excluir registros de outros operadores.' , ['&Ok']);
    Exit;
  end;

  FObjLiberacao.Clear;
  FObjLiberacao.objMsgLibera.pAddTexto('Manutenção de Ordem de Serviços - Excluir registro de comunicação interna');
  FObjLiberacao.objMsgLibera.pAddSeparador(75);
  FObjLiberacao.objMsgLibera.pAddTextoCaption('Ordem de Serviço:', objConEqu.strNumero                                                    , 18);
  FObjLiberacao.objMsgLibera.pAddTextoCaption('Cliente:'         , objConEqu.strCodCli + ' - ' + fRetNomCliente(objConEqu.strCodCli)      , 18);
  FObjLiberacao.objMsgLibera.pAddTextoCaption('Operador:'        , strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado), 18);

  FObjLiberacao.strDirAce := 'EXCCOMINT';
  FObjLiberacao.strMsgSen := 'Excluir registro de comunicação interna';
  FObjLiberacao.strCodOpe := strLoginUsuarioLogado;
  FObjLiberacao.strCpfCnpj := objConEqu.strCliCgc;

  If Not FObjLiberacao.fLibera Then
    Exit;

  FQryMsg.Delete;
end;

procedure TfrmFatManConsertoComunicacaoInterna.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatManConsertoComunicacaoInterna.btnGravarClick(Sender: TObject);
begin
  inherited;
  FQryMsg.Post;
end;

procedure TfrmFatManConsertoComunicacaoInterna.btnImprimirClick(
  Sender: TObject);
begin
  inherited;

    if Assigned(prcExecutaRelatorio) then
      prcExecutaRelatorio(158, 7178, [7178], ['NUMOSE','CODEMP'], [objConEqu.strNumero, objConEqu.strCodEmp], Sender, Nil, True);
end;

procedure TfrmFatManConsertoComunicacaoInterna.btnIncluirClick(Sender: TObject);
begin
  inherited;
  FQryMsg.Append;
  pSetFocus(memMsg);
end;

procedure TfrmFatManConsertoComunicacaoInterna.dtsMsgStateChange(
  Sender: TObject);
begin
  inherited;
  pAtualizaBotoes;
end;

procedure TfrmFatManConsertoComunicacaoInterna.FormCreate(Sender: TObject);
begin
  inherited;
  FQryMsg           := fCriaQuery(Self);
  FQryMsg.AfterOpen := pAfterOpen;
  FQryMsg.BeforePost := pBeforePost;
  dtsMsg.DataSet   := FQryMsg;
  FObjLiberacao := TLiberacao.Create;
end;

procedure TfrmFatManConsertoComunicacaoInterna.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FObjLiberacao);
end;

procedure TfrmFatManConsertoComunicacaoInterna.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
    pEscapePressed;


   If Key = VK_F6 Then
  Begin
    If (btnImprimir.Enabled) Then
      btnImprimir.Click;
  end;

end;

procedure TfrmFatManConsertoComunicacaoInterna.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaObs;
  cxgConsultaTable.ViewData.Collapse(True);
end;

procedure TfrmFatManConsertoComunicacaoInterna.pAfterOpen(DataSet: TDataSet);
begin
  TStringField(Dataset.FieldByName('OPERADOR')).OnGetText := pGetTextOperador;
  TDateTimeField(Dataset.FieldByName('EQC_HORENT')).OnGetText := pGetTextHora;
end;

procedure TfrmFatManConsertoComunicacaoInterna.pAtualizaBotoes;
begin
  btnIncluir.Enabled := (FQryMsg.State = dsBrowse) and (not objConEqu.blnOSCancelada);
  btnGravar.Enabled  := (FQryMsg.State in dsEditModes) and (not objConEqu.blnOSCancelada);
  btnAlterar.Enabled := btnIncluir.Enabled;
  btnExcluir.Enabled := btnIncluir.Enabled;
  btnCancela.Enabled := btnGravar.Enabled;
end;

procedure TfrmFatManConsertoComunicacaoInterna.pCarregaObs;
var
  strPre: String;
begin
  strPre := '';

  if objConEqu.blnOSCancelada then
    strPre := 'DEL_';

  Try
    FQryMsg.Close;
    FQryMsg.SQL.Clear;
    FQryMsg.SQL.Add(' SELECT ' + strPre + 'EQUCOM.*, ');
    FQryMsg.SQL.Add(' CAST("" AS CHAR(100)) AS OPERADOR ');
    FQryMsg.SQL.Add('   FROM ' + strPre + 'EQUCOM ');
    FQryMsg.SQL.Add('  WHERE EQC_SEQGER = :SEQGER ');
    FQryMsg.SQL.Add(' ORDER BY EQC_DTAENT, EQC_HORENT ');

    FQryMsg.ParamByName('SEQGER').AsString := objConEqu.strAutInc;
    FQryMsg.Open;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmFatManConsertoComunicacaoInterna.pCarregaObs]');
    End;
  End;
end;

procedure TfrmFatManConsertoComunicacaoInterna.pGetTextHora(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text := Sender.AsString.Substring(0, 5);
end;

procedure TfrmFatManConsertoComunicacaoInterna.pGetTextOperador(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text := FQryMsg.FieldByName('EQC_CODOPE').AsString + '-' + fRetNomeOperador(FQryMsg.FieldByName('EQC_CODOPE').AsString);
end;

procedure TfrmFatManConsertoComunicacaoInterna.pBeforePost(DataSet: TDataSet);
begin
  if DataSet.State = DsInsert then
  begin
    DataSet.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('EQUCOM', VS_strCodEmp);
    DataSet.FieldByName('EQC_SEQGER').AsString := objConEqu.strAutInc;
    DataSet.FieldByName('EQC_DTAENT').AsDateTime := VS_Date;
    DataSet.FieldByName('EQC_HORENT').AsDateTime := fTime();
    DataSet.FieldByName('EQC_CODOPE').AsString := strLoginUsuarioLogado;
    DataSet.FieldByName('EQC_NUMOSE').AsString := objConEqu.strNumero;
    DataSet.FieldByName('EQC_CODEMP').AsString := objConEqu.strCodEmp;
  end;
end;

end.

