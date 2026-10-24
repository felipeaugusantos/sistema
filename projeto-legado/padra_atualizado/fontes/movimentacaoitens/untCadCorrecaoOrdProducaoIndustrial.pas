unit untCadCorrecaoOrdProducaoIndustrial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxTextEdit, cxCurrencyEdit, cxButtonEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  Vcl.DBCtrls, DBEditFocus, EditFocus, Vcl.Mask, MaskEditFocus, untConsultas,
  untTypesSistema, untFuncoesSimples, untOrdProIndustrial, Uni, untOrdProIndCorrecoes,
  OrdemProducaoIndustrial.TCorrecao;

type
  TfrmCadCorrecaoOrdProducaoIndustrial = class(TfrmPai)
    pnlGridCorrecao: TPanel;
    pnlCorrecao: TPanel;
    btnIncluir: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    cxgCorrecoes: TcxGrid;
    cxgCorrecoesViewMATBOPNao: TcxGridDBTableView;
    cxgCorrecoesViewMATBOPNaoColumn1: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPNaoColumn2: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPNaoColumn3: TcxGridDBColumn;
    cxgCorrecoesQTDITE: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPNaoColumn5: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPSim: TcxGridDBTableView;
    cxgCorrecoesViewMATBOPSimIT: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPSimDESCRICAO: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPSimREFERENCIA: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPSimQTDOP: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPSimQTDUTILIZADA: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPSimCORRECAO: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPSimExcluir: TcxGridDBColumn;
    cxgCorrecoesLevel1: TcxGridLevel;
    Panel1: TPanel;
    Label1: TLabel;
    Label5: TLabel;
    mskDtaCad: TMaskEditFocus;
    edtNumOrd: TEditFocus;
    dbeCodIte: TDBEditFocus;
    dbeDesIte: TDBEditFocus;
    Panel2: TPanel;
    btnConfirma: TBitBtnLocked;
    btnConcluiCorrecao: TBitBtnLocked;
    dtsOrdPro: TDataSource;
    cxgCorrecoesViewMATBOPSimOPECON: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPSimDTACON: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPSimHRACON: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPNaoOPECON: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPNaoDTACON: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPNaoHRACON: TcxGridDBColumn;
    procedure edtNumOrdKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnConcluiCorrecaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgCorrecoesViewMATBOPSimOPECONGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxgCorrecoesViewMATBOPNaoOPECONGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
  private
    { Private declarations }
    objOrdPro: TOrdProIndustrial;
    objCorrOP: TOrdProIndCorrecoes;
    qryOrdPro: TUniQuery;

    procedure pCreateObjCorrecao(blnCarregaDadosSalvos: Boolean = False; strAutInc: String = '');
    function fVerificaOpiConcluida: Boolean;
  public
    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

var
  frmCadCorrecaoOrdProducaoIndustrial: TfrmCadCorrecaoOrdProducaoIndustrial;

CONST
  SQL_CORRECAO = ' SELECT *,                             '+
                 '        0.0000 AS QTD_OP ,             '+
                 '        0.0000 AS QTD_UTILIZADA,       '+
                 '        "" AS REFERENCIA FROM DEICOR D ';

  SQL_CORRECAO_WHERE = ' WHERE DMT_SEQORD = :SEQORD ';

  SQL_UPDATE_STATUS_CORRECAO = 'UPDATE ORDGER SET ORD_CRRFIN = :CRRFIN';

  SQL_UPDATE_STATUS_CORRECAO_WHERE = 'WHERE AUTOINCREM = :AUTINC';

  SQL_CONSULTA_CORRECOES_CONCLUIDA = 'SELECT ORD_CRRFIN FROM ORDGER ';

  SQL_CONSULTA_CORRECOES_CONCLUIDA_WHERE = ' WHERE AUTOINCREM = :AUTINC AND ORD_CRRFIN = "1" ';



implementation

{$R *.dfm}

procedure TfrmCadCorrecaoOrdProducaoIndustrial.btnAlterarClick(Sender: TObject);
begin
  inherited;

  If fVerificaOpiConcluida Then
  Begin
    pMensagemOk('Correção já concluída!');
    Exit;
  End;

  If not TBitBtnLocked(Sender).Visible Then Exit;
  objCorrOP.fAlteraCorrecao;

end;

function TfrmCadCorrecaoOrdProducaoIndustrial.fVerificaOpiConcluida: Boolean;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta:= fCriaQuery(Nil);
  Try

    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(SQL_CONSULTA_CORRECOES_CONCLUIDA);
    qryConsulta.SQL.Add(SQL_CONSULTA_CORRECOES_CONCLUIDA_WHERE);
    qryConsulta.ParamByName('AUTINC').AsString:= qryOrdPro.FieldByName('AUTINC').AsString;
    qryConsulta.Open;

    result:= Not(qryConsulta.IsEmpty);

  Finally
    FreeAndNil(qryConsulta);
  End;

end;

procedure TfrmCadCorrecaoOrdProducaoIndustrial.btnConcluiCorrecaoClick(
  Sender: TObject);
var
  qryDados: TUniQuery;
begin
  If fVerificaOpiConcluida Then
  Begin
    pMensagemOk('Correção já concluída!');
    Exit;
  End;

  If fPergunta('Deseja concluir as correções ?') Then
  Begin
    qryDados:= fCriaQuery(Nil);
    Try

      qryDados.Close;
      qryDados.SQL.Clear;
      qryDados.SQL.Add(SQL_UPDATE_STATUS_CORRECAO);
      qryDados.SQL.Add(SQL_UPDATE_STATUS_CORRECAO_WHERE);
      qryDados.ParamByName('CRRFIN').AsString:= '1';
      qryDados.ParamByName('AUTINC').AsString:= qryOrdPro.FieldByName('AUTINC').AsString;
      qryDados.ExecSQL;

      pMensagemOk('Correção concluída com sucesso!');
    Finally
      FreeAndNil(qryDados);
    End;
  End;
end;

procedure TfrmCadCorrecaoOrdProducaoIndustrial.btnConfirmaClick(
  Sender: TObject);
begin
  inherited;

  If fVerificaOpiConcluida Then
  Begin
    pMensagemOk('Correção já concluída!');
    Exit;
  End;

  If objCorrOP.fGravaCorrecoes(qryOrdPro.FieldByName('AUTINC').AsString, VS_strCodEmp, True) Then
  Begin
    pMensagemOk('Correção gravada com sucesso');
  End;
end;

procedure TfrmCadCorrecaoOrdProducaoIndustrial.btnExcluirClick(Sender: TObject);
begin
  inherited;

  If fVerificaOpiConcluida Then
  Begin
    pMensagemOk('Correção já concluída!');
    Exit;
  End;

  If not TBitBtnLocked(Sender).Visible Then Exit;
  objCorrOP.fExcluiCorrecao;
end;

procedure TfrmCadCorrecaoOrdProducaoIndustrial.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If fVerificaOpiConcluida Then
  Begin
    pMensagemOk('Correção já concluída!');
    Exit;
  End;

  If not TBitBtnLocked(Sender).Visible Then Exit;
  objCorrOP.fIncluiCorrecao;
end;

procedure TfrmCadCorrecaoOrdProducaoIndustrial.cxgCorrecoesViewMATBOPNaoOPECONGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If Not FEmptyStr(AText) Then
    AText := AText+'-'+fRetNomeOperador(AText);
end;

procedure TfrmCadCorrecaoOrdProducaoIndustrial.cxgCorrecoesViewMATBOPSimOPECONGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If Not FEmptyStr(AText) Then
    AText := AText+'-'+fRetNomeOperador(AText);
end;

procedure TfrmCadCorrecaoOrdProducaoIndustrial.edtNumOrdKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrTabela : TConsultasArray;
begin
  inherited;

  If fPesqOrdProIndustrial(Self, edtNumOrd, mskDtaCad, Nil, Key, arrTabela, poiCodigo, True, staAbertas) Then
  Begin
    If fValidaCampos(edtNumOrd, True) And
       fValidaCampos(mskDtaCad, True) Then
    Begin

      pSetFocus(btnIncluir);

    End;

  End;

end;

procedure TfrmCadCorrecaoOrdProducaoIndustrial.pCreateObjCorrecao(blnCarregaDadosSalvos: Boolean = False; strAutInc: String = '');
Begin
  If objCorrOP <> Nil Then
    objCorrOP:= Nil;

  If blnCarregaDadosSalvos Then
    objCorrOP := TOrdProIndCorrecoes.Create(Self, blnCarregaDadosSalvos, strAutInc)
  Else
    objCorrOP := TOrdProIndCorrecoes.Create(Self);

  objCorrOP.objOrdPro := objOrdPro;

  if objCorrOP.blnMATBOP then
  begin
    cxgCorrecoesViewMATBOPSim.DataController.DataSource := objCorrOP.dtsSource;
    cxgCorrecoesLevel1.GridView := cxgCorrecoesViewMATBOPSim;
    btnAlterar.Visible := False;
  end
  else
  begin
    cxgCorrecoesViewMATBOPNao.DataController.DataSource := objCorrOP.dtsSource;
    cxgCorrecoesLevel1.GridView := cxgCorrecoesViewMATBOPNao;
  end;

End;


procedure TfrmCadCorrecaoOrdProducaoIndustrial.FormCreate(Sender: TObject);
begin
  inherited;

  objOrdPro := TOrdProIndustrial.Create(Self, Nil, Nil, False, True);

  pCreateObjCorrecao;

  qryOrdPro := fCriaQuery(Self);
  dtsOrdPro.DataSet := qryOrdPro;

end;

procedure TfrmCadCorrecaoOrdProducaoIndustrial.FormDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(objOrdPro) then
    FreeAndNil(objOrdPro);

  if Assigned(qryOrdPro) then
    FreeAndNil(qryOrdPro);

  if Assigned(objCorrOP) then
    FreeAndNil(objCorrOP);

end;

procedure TfrmCadCorrecaoOrdProducaoIndustrial.FormShow(Sender: TObject);
begin
  inherited;
  If edtNumOrd.Enabled Then
    pSetFocus(edtNumOrd);
end;

function TfrmCadCorrecaoOrdProducaoIndustrial.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtNumOrd) Then
  Begin

    If fEmptyStrEspeciais(edtNumOrd.Text) Then
    Begin
      pMensagemOk('Informe o Número da Ordem de Produção!');
      Result := False;
    End

  End Else

  If (Sender = mskDtaCad) Then
  Begin

    If fEmptyDate(mskDtaCad.Text) Then
    Begin
      pMensagemOk('Informe a Data de Cadastro da Ordem de Produção!');
      Result := False;
    End Else

    If Not objOrdPro.fExisteLoteOP(qryOrdPro, edtNumOrd.Text, StrToDateDef(mskDtaCad.Text, 0)) Then
    Begin
      Result := False;
      pMensagemOk('Ordem de Produção não encontrada!');
    End Else

    If fExisteCorrecao(qryOrdPro.FieldByName('AUTINC').AsString) Then
    Begin
      objCorrOP.qryQuery.Close;
      objCorrOP.qryQuery.SQL.Clear;
      objCorrOP.qryQuery.SQL.Add(SQL_CORRECAO);
      objCorrOP.qryQuery.SQL.Add(SQL_CORRECAO_WHERE);
      objCorrOP.qryQuery.ParamByName('SEQORD').AsString:= qryOrdPro.FieldByName('AUTINC').AsString;
      objCorrOP.qryQuery.Open;
      pCreateObjCorrecao(True, qryOrdPro.FieldByName('AUTINC').AsString);
    End
    Else
      pCreateObjCorrecao;

  End;

  If Result then
  Begin
    pSetFocus(btnIncluir);
  End;

end;

end.
