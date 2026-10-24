unit untCadManutInventario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  DB, Uni, Mask, DBCtrls, DBEditFocus,  StrUtils, cxProgressBar, System.UITypes,
  AppEvnts, Grids, DBGridCitel, DBGrids, BitBtnLockedIncrem, DBAccess, MemDS, frxClass,
  frxExportCSVTestabilidade, untfuncoesSimples, untZClient, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxCurrencyEdit;

type
  TfrmCadManutInventario = class(TfrmPaiCad)
    pnlDados: TPanel;
    btnAjustar: TBitBtnLocked;
    shpAltera: TShape;
    Label1: TLabel;
    Shape1: TShape;
    Label2: TLabel;
    Panel1: TPanel;
    Label3: TLabel;
    cmbPreInv: TComboBox;
    cxgItens: TcxGridDBTableView;
    cxlItens: TcxGridLevel;
    cxItens: TcxGrid;
    cxgItensCODITE: TcxGridDBColumn;
    cxgItensCODGRU: TcxGridDBColumn;
    cxgItensCODABF: TcxGridDBColumn;
    cxgItensCODUNI: TcxGridDBColumn;
    cxgItensDESITE: TcxGridDBColumn;
    cxgItensPREULT: TcxGridDBColumn;
    cxgItensREFERE: TcxGridDBColumn;
    cxgItensSALDOS: TcxGridDBColumn;
    cxgItensSAL_ML: TcxGridDBColumn;
    cxgItensCNV_ML: TcxGridDBColumn;
    cxgItensPRECOM: TcxGridDBColumn;
    cxgItensPRECUS: TcxGridDBColumn;
    cxgItensPREVE1: TcxGridDBColumn;
    cxgItensPREVE2: TcxGridDBColumn;
    cxgItensPREVE3: TcxGridDBColumn;
    cxgItensPREVE4: TcxGridDBColumn;
    cxgItensPREVE5: TcxGridDBColumn;
    cxgItensPREVE6: TcxGridDBColumn;
    cxgItensPREVE7: TcxGridDBColumn;
    cxgItensPREMED: TcxGridDBColumn;
    cxgItensSALBAL: TcxGridDBColumn;
    cxgItensIMPULT: TcxGridDBColumn;
    cxgItensAltera: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxgItensDESMAR: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAjustarClick(Sender: TObject);
    procedure pVerificaIntegridade;
    procedure qrySalInvBeforeInsert(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgItensTitleClick(Column: TColumn);
    procedure dbgItensExit(Sender: TObject);
    procedure dbgItensColExit(Sender: TObject);
    procedure pCarregaComboPreInv(strPreInv: String);
    procedure cmbPreInvChange(Sender: TObject);
    procedure cxgItensCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    { Private declarations }
    cdsSalInv: TZClient;
    recPreInv : TPreInvValues;

    qryUpdate: TUniQuery;
    qryInsertLog: TUniQuery;
    qryLocateValAnt: TUniQuery;

    strCamPre,
    strColOrdem: String;
    blnImpUlt  : Boolean;
    blnUsaTmq  : Boolean;
    strCampo : String;
    function fCarregaProdutos(cxProgress : TcxProgressBar):Boolean;
    function fTeveAlteracao: String;
    function fOrdenaColuna(cxProgress : TcxProgressBar):Boolean;
    Procedure pAfterPost(dataSource: TDataSet);
    procedure pSetaValoresOriginais(strCamPre, strCodIte, strCodEmp: String; var fltValPreAnt: Double;  var fltSalAnt: Double; var fltSalMlAnt: Double);
    function fGetSQLInsertLog: String;
    function fGetSQLLocate: String;

    procedure OnScroll(DataSet: TDataSet);
    Procedure pBeforePost(DataSet: TDataSet);
    procedure pPreparaGrid;
    function fRetornaColunaByFieldName(FieldName: String): TcxGridDBColumn;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }

    strNomTab: String;
  end;

var
  frmCadManutInventario: TfrmCadManutInventario;

implementation

uses untModulo, untCadManutInvFator, untGravando, untConstantes;

{$R *.dfm}

procedure TfrmCadManutInventario.FormCreate(Sender: TObject);
begin
  inherited;

  blnUsaTmq := fCfgSis('USATMQ', varBoolean);
  qryInsertLog := fCriaQuery(Self);

  qryLocateValAnt := fCriaQuery(Self);


  cdsSalInv := TZClient.Create(Self);

  qryUpdate := fCriaQuery(Self);

  strColOrdem := 'ITE_DESITE';

  pCarregaComboPreInv(fCfgSis('PREINV'));

  cxgItens.DataController.DataSource := cdsSalInv.dtsSource;

  cxgItensCNV_ML.Visible := blnUsaTmq;
  cxgItensSAL_ML.Visible := blnUsaTmq;

  cdsSalInv.BeforePost := pBeforePost;
  WindowState := wsMaximized;
end;

procedure TfrmCadManutInventario.pInicializaIndices;
begin
  inherited;
end;

function TfrmCadManutInventario.fRetornaColunaByFieldName(FieldName: String): TcxGridDBColumn;
begin
  If FieldName = 'ITE_CODITE' Then
    Result := cxgItensCODITE
  Else If FieldName = 'ITE_CODGRU' Then
    Result := cxgItensCODGRU
  Else If FieldName = 'ITE_CODABF' Then
    Result := cxgItensCODABF
  Else If FieldName = 'ITE_CODUNI' Then
    Result := cxgItensCODUNI
  Else If FieldName = 'ITE_DESITE' Then
    Result := cxgItensDESITE
  Else If FieldName = 'ITE_REFERE' Then
    Result := cxgItensREFERE
  Else If FieldName = 'ITE_SALDOS' then
    Result := cxgItensSALDOS
  Else If FieldName = 'ITE_SAL_ML' Then
    Result := cxgItensSAL_ML
  Else If FieldName = 'ITE_CNV_ML' Then
    Result := cxgItensCNV_ML
  Else If FieldName = 'ITE_PRECOM' Then
    Result := cxgItensPRECOM
  Else If FieldName = 'ITE_PRECUS' Then
    Result := cxgItensPRECUS
  Else If FieldName = 'ITE_PREVE1' Then
    Result := cxgItensPREVE1
  Else If FieldName = 'ITE_PREVE2' Then
    Result := cxgItensPREVE2
  Else If FieldName = 'ITE_PREVE3' Then
    Result := cxgItensPREVE3
  Else If FieldName = 'ITE_PREVE4' Then
    Result := cxgItensPREVE4
  Else If FieldName = 'ITE_PREVE5' Then
    Result := cxgItensPREVE5
  Else If FieldName = 'ITE_PREVE6' Then
    Result := cxgItensPREVE6
  Else If FieldName = 'ITE_PREVE7' Then
    Result := cxgItensPREVE7
  Else If FieldName = 'ITE_PREMED' Then
    Result := cxgItensPREMED
  Else If FieldName = 'ITE_PREULT' Then
    Result := cxgItensPREULT
  Else If FieldName = 'ITE_IMPULT' Then
    Result := cxgItensIMPULT
  Else If FieldName = 'ITE_SALBAL' Then
    Result := cxgItensSALBAL
  Else Result := Nil;
{}
end;


function TfrmCadManutInventario.fTeveAlteracao: String;
begin
    If (((strCamPre <> 'ULTFED') And (strCamPre <> 'ITE_PRELIQ') and ((cdsSalInv.FieldByName(strCampo).Value) = (cdsSalInv.FieldByName(strCampo).OldValue))) And
      ((cdsSalInv.FieldByName('ITE_SALDOS').Value) = (cdsSalInv.FieldByName('ITE_SALDOS').OldValue)) And
      ((cdsSalInv.FieldByName('ITE_SAL_ML').Value) = (cdsSalInv.FieldByName('ITE_SAL_ML').OldValue))) Then
    Result := 'N'
  Else
    Result := 'S';
end;

function TfrmCadManutInventario.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
end;


procedure TfrmCadManutInventario.OnScroll(DataSet: TDataSet);
begin
  cxgItensSAL_ML.Options.Editing := cxgItens.DataController.DataSource.DataSet.FieldByName('ITE_CNV_ML').AsFloat > 0;
end;

procedure TfrmCadManutInventario.FormShow(Sender: TObject);
begin

  pVerificaIntegridade;
  strNomeTabela      := strNomTab;

  blnImpUlt := fCampoExiste(strNomTab, 'ITE_IMPULT');

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fCarregaProdutos;
    frmGravando.pgbStatus.Visible := False;
    frmGravando.lblGravando.Caption := 'Carregando informações, Aguarde...';
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;

  btnIncluir.Visible := False;
  btnExcluir.Visible := False;

  pPreparaGrid;
  qryInsertLog.SQL.Add(fGetSQLInsertLog);
  qryLocateValAnt.SQL.Add(fGetSQLLocate);
end;

procedure TfrmCadManutInventario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key of
    VK_F4     : btnAjustar.Click;
    VK_RETURN : If cdsSalInv.State = dsEdit Then
                  cdsSalInv.Post;
  End;
end;

procedure TfrmCadManutInventario.btnAjustarClick(Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(TfrmCadManutInvFator, frmCadManutInvFator);
    frmCadManutInvFator.strNomTab := strNomTab;

    frmCadManutInvFator.recPreInv := recPreInv;
    frmCadManutInvFator.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCadManutInventario.btnAjustarClick]');
    End;
  End;
  pFreeAndNil(frmCadManutInvFator);

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fCarregaProdutos;
    frmGravando.pgbStatus.Visible := False;
    frmGravando.lblGravando.Caption := 'Carregando informações, Aguarde...';

    pPreparaGrid;


    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;

end;

{*******************************************}
{* VERIFICA INTEGRIDADE DOS VALORES        *}
{****************************************AF*}
procedure TfrmCadManutInventario.pVerificaIntegridade;
  Var
    qryGen: TUniQuery;
    blnTab1: Boolean;
    blnTab2: Boolean;
    blnTab3: Boolean;
    blnTab4: Boolean;
    blnTab5: Boolean;
    blnTab6: Boolean;
    blnTab7: Boolean;
Begin

  Try
    qryGen := fCriaQuery;
    blnTab1 := False;
    blnTab2 := False;
    blnTab3 := False;
    blnTab4 := False;
    blnTab5 := False;
    blnTab6 := False;
    blnTab7 := False;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('DESC ' + strNomTab);
      Open;

      If Not Locate('Field','ITE_PREVE1',[]) Then blnTab1 := True;
      If Not Locate('Field','ITE_PREVE2',[]) Then blnTab2 := True;
      If Not Locate('Field','ITE_PREVE3',[]) Then blnTab3 := True;
      If Not Locate('Field','ITE_PREVE4',[]) Then blnTab4 := True;
      If Not Locate('Field','ITE_PREVE5',[]) Then blnTab5 := True;
      If Not Locate('Field','ITE_PREVE6',[]) Then blnTab6 := True;
      If Not Locate('Field','ITE_PREVE7',[]) Then blnTab7 := True;

      If blnTab1 Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add('ALTER TABLE ' + strNomTab + ' ADD ITE_PREVE1 NUMERIC(12,2) DEFAULT 0.00 ');
        ExecSQL;
      End;
      If blnTab2 Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add('ALTER TABLE ' + strNomTab + ' ADD ITE_PREVE2 NUMERIC(12,2) DEFAULT 0.00 ');
        ExecSQL;
      End;
      If blnTab3 Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add('ALTER TABLE ' + strNomTab + ' ADD ITE_PREVE3 NUMERIC(12,2) DEFAULT 0.00 ');
        ExecSQL;
      End;
      If blnTab4 Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add('ALTER TABLE ' + strNomTab + ' ADD ITE_PREVE4 NUMERIC(12,2) DEFAULT 0.00 ');
        ExecSQL;
      End;
      If blnTab5 Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add('ALTER TABLE ' + strNomTab + ' ADD ITE_PREVE5 NUMERIC(12,2) DEFAULT 0.00 ');
        ExecSQL;
      End;
      If blnTab6 Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add('ALTER TABLE ' + strNomTab + ' ADD ITE_PREVE6 NUMERIC(12,2) DEFAULT 0.00 ');
        ExecSQL;
      End;
      If blnTab7 Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add('ALTER TABLE ' + strNomTab + ' ADD ITE_PREVE7 NUMERIC(12,2) DEFAULT 0.00 ');
        ExecSQL;
      End;

    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

function TfrmCadManutInventario.fCarregaProdutos(cxProgress : TcxProgressBar):Boolean;
  Var
    strSQL: String;
begin
  Result := True;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.AUTOINCREM, ';
  strSQL := strSQL + '  C.ITE_CODITE, ';
  strSQL := strSQL + '  I.ITE_CODGRU, ';
  strSQL := strSQL + '  I.ITE_CODEMP, ';
  strSQL := strSQL + '  I.ITE_CODABF, ';
  strSQL := strSQL + '  I.ITE_CODUNI, ';
  strSQL := strSQL + '  C.ITE_DESITE, ';
  strSQL := strSQL + '  I.ITE_REFERE, ';
  strSQL := strSQL + '  I.ITE_PREVE1, ';
  strSQL := strSQL + '  I.ITE_PREVE2, ';
  strSQL := strSQL + '  I.ITE_PREVE3, ';
  strSQL := strSQL + '  I.ITE_PREVE4, ';
  strSQL := strSQL + '  I.ITE_PREVE5, ';
  strSQL := strSQL + '  I.ITE_PREVE6, ';
  strSQL := strSQL + '  I.ITE_PREVE7, ';
  strSQL := strSQL + '  I.ITE_PREMED, ';
  strSQL := strSQL + '  I.ITE_PREULT, ';
  strSQL := strSQL + '  M.MAR_DESMAR, ';

  if blnImpUlt Then
    strSQL := strSQL + '        I.ITE_IMPULT, '
  Else
    strSQL := strSQL + '  0.00 AS ITE_IMPULT, ';

  strSQL := strSQL + '  I.ITE_PRECOM, ';
  strSQL := strSQL + '  I.ITE_PRECUS, ';
  strSQL := strSQL + '  I.ITE_SALBAL, ';
  strSQL := strSQL + '  I.ITE_SALDOS, ';
  strSQL := strSQL + '  I.ITE_SAL_ML, ';
  strSQL := strSQL + '  I.ITE_CNV_ML, ';
  strSQL := strSQL + ' "N" AS ALTERA, ';
  strSQL := strSQL + '  U.UNI_ITEFRA, ';
  strSQL := strSQL + fPreInv('I','B', 'ULTFED') + ' AS ULTFED,  ';
  strSQL := strSQL + fPreInv('I','B', 'PRELIQ') + ' AS ITE_PRELIQ  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ' + strNomTab + ' AS I ';
  strSQL := strSQL + '  JOIN CADITE C ON C.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '  LEFT JOIN ITEGER B ON  B.ITE_CODITE = I.ITE_CODITE AND B.ITE_CODEMP = I.ITE_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN CADMAR M ON M.MAR_CODMAR = C.ITE_CODMAR ';
  strSQL := strSQL + '  INNER JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  I.ITE_CODEMP = :CODEMP ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  ' + strColOrdem + ' ';

  If Not blnImpUlt Then
    cxgItensIMPULT.Visible := False;

  Application.ProcessMessages;

  cdsSalInv.qryQuery.sql.Text := strSQL;
  cdsSalInv.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

  cdsSalInv.fAbreClient(True, 'TfrmCadManutInventario.fCarregaProdutos');
  cdsSalInv.AfterScroll := OnScroll;
  cdsSalInv.AfterPost := pAfterPost;
end;

function TfrmCadManutInventario.fGetSQLInsertLog: String;
begin
  Result := '';
  Result := Result + 'INSERT INTO LOGINV(';
  Result := Result + '  LOG_DTAOCO,';
  Result := Result + '  LOG_HOROCO,';
  Result := Result + '  LOG_CODOPE,';
  Result := Result + '  LOG_TABELA,';
  Result := Result + '  LOG_CODITE,';
  Result := Result + '  LOG_CODEMP,';

  Result := Result + '  LOG_PREANT,';
  Result := Result + '  LOG_PRENOV,';
  Result := Result + '  LOG_CAMPRE,';

  Result := Result + '  LOG_SALANT,';
  Result := Result + '  LOG_SALNOV,';
  Result := Result + '  LOG_SMLANT,';
  Result := Result + '  LOG_SMLNOV ';


  Result := Result + '  ) VALUES (';
  Result := Result + '  CURDATE(),';
  Result := Result + '  CURTIME(),';
  Result := Result + '  "'+ strLoginUsuarioLogado +'",';
  Result := Result + '  "'+ strNomTab +'",';
  Result := Result + '  :LOG_CODITE,';
  Result := Result + '  :LOG_CODEMP,';
  Result := Result + '  :LOG_PREANT,';
  Result := Result + '  :LOG_PRENOV,';
  Result := Result + '  :LOG_CAMPRE,';
  Result := Result + '  :LOG_SALANT,';
  Result := Result + '  :LOG_SALNOV,';
  Result := Result + '  :LOG_SMLANT,';
  Result := Result + '  :LOG_SMLNOV ';
  Result := Result + ')';

end;



procedure TfrmCadManutInventario.pSetaValoresOriginais(strCamPre, strCodIte, strCodEmp: String;
  var fltValPreAnt, fltSalAnt, fltSalMlAnt: Double);
begin
  qryLocateValAnt.Close;
  qryLocateValAnt.SQL.Clear;
  qryLocateValAnt.SQL.Add(fGetSQLLocate);
  qryLocateValAnt.ParamByName('CODITE').AsString := strCodIte;
  qryLocateValAnt.ParamByName('CODEMP').AsString := strCodEmp;
  qryLocateValAnt.Open;

  fltValPreAnt := qryLocateValAnt.FieldByname(strCamPre).AsFloat;
  fltSalAnt    := qryLocateValAnt.FieldByname('ITE_SALDOS').AsFloat;
  fltSalMlAnt  := qryLocateValAnt.FieldByname('ITE_SAL_ML').AsFloat;
end;

function TfrmCadManutInventario.fGetSQLLocate: String;
var
  strCamInt: String;
begin
  strCamInt := strCamPre;

  If  strCamInt = 'ULTFED' Then
  Begin
    Result := Result + 'SELECT  ';
    Result := Result + fPreInv('I','B', 'ULTFED') + ' AS ULTFED,  ';
    Result := Result + ' I.ITE_SALDOS, I.ITE_SAL_ML ';
    Result := Result + 'FROM ';
    Result := Result + '  ' + strNomTab + ' AS I ';
    Result := Result + '  LEFT JOIN ITEGER B ON  B.ITE_CODITE = I.ITE_CODITE AND B.ITE_CODEMP = I.ITE_CODEMP ';
    Result := Result + ' WHERE I.ITE_CODITE = :CODITE';
    Result := Result + '  AND I.ITE_CODEMP = :CODEMP';
    exit;
  End;

  If strCamInt = 'ITE_PRELIQ' Then
    strCamInt := 'ROUND(ITE_PRECOM * (1 - ITE_DESF01 / 100) * '+
                   '(1 - ITE_DESF02 / 100) * ' +
                   '(1 - ITE_DESF03 / 100) * ' +
                   '(1 - ITE_DESF04 / 100) * ' +
                   '(1 - ITE_DESF05 / 100) * ' +
                   '(1 - ITE_DESF06 / 100), 2) AS ITE_PRELIQ';

  Result := Result + 'SELECT ' + strCamInt + ', ITE_SALDOS, ITE_SAL_ML  FROM ' +  strNomTab;
  Result := Result + ' WHERE ITE_CODITE = :CODITE';
  Result := Result + '  AND ITE_CODEMP = :CODEMP';
end;

function TfrmCadManutInventario.fOrdenaColuna(cxProgress : TcxProgressBar):Boolean;
begin
  Result := True;
  cdsSalInv.IndexFieldNames := strColOrdem;
end;

Procedure TfrmCadManutInventario.pAfterPost(dataSource: TDataSet);
var fltValPreAnt,  fltSalAnt, fltSalMlAnt: Double;
Begin
  With dataSource Do
  Begin
    pSetaValoresOriginais(strCamPre,
                          FieldByName('ITE_CODITE').AsString,
                          FieldByName('ITE_CODEMP').AsString,
                          fltValPreAnt,  fltSalAnt, fltSalMlAnt);
    qryInsertLog.ParamByName('LOG_CODITE').AsString := FieldByName('ITE_CODITE').AsString;
    qryInsertLog.ParamByName('LOG_CODEMP').AsString := FieldByName('ITE_CODEMP').AsString;

    qryInsertLog.ParamByName('LOG_PREANT').AsFloat := fltValPreAnt;
    qryInsertLog.ParamByName('LOG_PRENOV').AsFloat:=  FieldByName(strCamPre).AsFloat;
    qryInsertLog.ParamByName('LOG_CAMPRE').AsString := strCamPre;

    qryInsertLog.ParamByName('LOG_SALANT').AsFloat := fltSalAnt;
    qryInsertLog.ParamByName('LOG_SALNOV').AsFloat := FieldByName('ITE_SALDOS').AsFloat;
    qryInsertLog.ParamByName('LOG_SMLANT').AsFloat := fltSalMlAnt;
    qryInsertLog.ParamByName('LOG_SMLNOV').AsFloat := FieldByName('ITE_SAL_ML').AsFloat;

    qryUpdate.Close;
    qryUpdate.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
    qryUpdate.ParamByName('CODEMP').AsString := FieldByName('ITE_CODEMP').AsString;
    qryUpdate.ParamByName('SALDOS').AsFloat  := FieldByName('ITE_SALDOS').AsFloat;
    qryUpdate.ParamByName('SAL_ML').AsFloat  := FieldByName('ITE_SAL_ML').AsFloat;

    If (cdsSalInv.FindField(strCamPre) <> Nil) And (strCamPre <> 'ULTFED') And (strCamPre <> 'ITE_PRELIQ') Then
      qryUpdate.ParamByName('CAMPRE').AsFloat  := FieldByName(strCamPre).AsFloat;

    qryUpdate.ExecSQL;



    qryInsertLog.ExecSQL;
  End;

  try
    cdsSalInv.AfterPost := nil;
    cdsSalInv.Edit;
    cdsSalInv.FieldByName('ALTERA').AsString := fTeveAlteracao;
    cdsSalInv.Post;
  finally
    cdsSalInv.AfterPost := pAfterPost;
  end;
End;

procedure TfrmCadManutInventario.pBeforePost(DataSet: TDataSet);
begin
  If DataSet.State In [dsEdit] Then
  Begin
    If (DataSet.FieldByName('UNI_ITEFRA').AsString = 'N') And
       (StrToIntDef(DataSet.FieldByName('ITE_SALDOS').AsString, 0) = 0) And
        (DataSet.FieldByName('ITE_SALDOS').Value <> 0) And
        ((DataSet.FieldByName('ITE_SALDOS').Value) <> (DataSet.FieldByName('ITE_SALDOS').OldValue)) Then
    Begin
      DataSet.Cancel;
      fMensagem('ATENÇÃO!', 'Produto não fracionado, informe um valor inteiro!', ['&Ok']);
      Abort;
    End;
  End;
end;

procedure TfrmCadManutInventario.qrySalInvBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  DataSet.Cancel;
end;

procedure TfrmCadManutInventario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //inherited;
end;

procedure TfrmCadManutInventario.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
    Close;
end;

procedure TfrmCadManutInventario.dbgItensTitleClick(Column: TColumn);
begin
  inherited;
  If Assigned(Column) Then
  Begin
    If cdsSalInv.State = dsEdit Then
      cdsSalInv.Post;

    strColOrdem := Column.FieldName;
    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fOrdenaColuna;
      frmGravando.pgbStatus.Visible := False;
      frmGravando.lblGravando.Caption := 'Carregando informações, Aguarde...';
      frmGravando.ShowModal;
    Finally
      FreeAndNil(frmGravando);
    End;
  End;
end;

procedure TfrmCadManutInventario.dbgItensExit(Sender: TObject);
begin
  inherited;
  If cdsSalInv.State = dsEdit Then
    cdsSalInv.Post;
end;

procedure TfrmCadManutInventario.dbgItensColExit(Sender: TObject);
begin
  inherited;
  If cdsSalInv.State = dsEdit Then
    cdsSalInv.Post;
end;

procedure TfrmCadManutInventario.pCarregaComboPreInv(strPreInv: String);
  var
    i: Integer;
begin
  For i := low(arrPreInvDesc) To High(arrPreInvDesc) Do
    cmbPreInv.AddItem(arrPreInvDesc[i], nil);
  If recPreInv.strCodigo = '' Then
    recPreInv.pCarregaRecordPeloCodigo(strPreInv);
  cmbPreInv.ItemIndex := recPreInv.intIndex;
  If recPreInv.strCodigo = 'IMPULT' Then
    strCampo := 'ITE_' + recPreInv.strCodigo
  Else
    strCampo := 'ITE_PRE' + recPreInv.strCodigo;
end;

procedure TfrmCadManutInventario.cmbPreInvChange(Sender: TObject);
begin
  inherited;
  recPreInv.pCarregaRecordPeloIndex(cmbPreInv.ItemIndex);
  If recPreInv.strCodigo = 'IMPULT' Then
    strCampo := 'ITE_' + recPreInv.strCodigo
  Else
    strCampo := 'ITE_PRE' + recPreInv.strCodigo;
  pPreparaGrid;
end;

procedure TfrmCadManutInventario.cxgItensCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensAltera.Index]) = 'S' Then
  Begin
    ACanvas.Brush.Color := clAqua;
    ACanvas.Font.Color  := clBlack;
  End;

  If TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName =  strColOrdem Then
  Begin
    ACanvas.Brush.Color:= clInfoBk;
    ACanvas.Font.Color:= clWindowText;
  End;

  If (TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName = strCampo) Or
     (TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName = 'ITE_SALDOS') Or
     ((TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName = 'ITE_SAL_ML') And (blnUsaTmq)) Then
  Begin
    ACanvas.Brush.Color:= ShpAltera.Brush.Color;
    ACanvas.Font.Color:= clBlack;
  End;
end;

procedure TfrmCadManutInventario.pPreparaGrid;
  Var
    intCont: integer;
    intNumDec: Integer;

begin
  For intCont := 0 To cxgItens.ColumnCount -1 Do
    cxgItens.Columns[intCont].Options.Editing := False;

  Try
    If recPreInv.strCodigo =  'IMPULT' Then
       strCamPre := 'ITE_IMPULT'
    Else If recPreInv.strCodigo =  'PRELIQ' Then
       strCamPre := 'ITE_PRELIQ'
    Else if Length(recPreInv.strCodigo) = 3 Then
       strCamPre := 'ITE_PRE' + recPreInv.strCodigo
    Else
       strCamPre := 'ULTFED';
  Except
    strCamPre := 'ITE_PREVE1';
  End;

  cxgItensSALDOS.Options.Editing := True;

  If Assigned(fRetornaColunaByFieldName(strCamPre)) Then
    fRetornaColunaByFieldName(strCamPre).Options.Editing := True;
  cxgItensSALDOS.Options.Editing := True;
//  cdsSalInv.FindField('ITE_SALDOS').ReadOnly := False;
//  cdsSalInv.FindField('ALTERA').ReadOnly := False;
  WindowState := wsMaximized;

  qryUpdate.SQL.Clear;
  qryUpdate.SQL.Add('UPDATE ' + strNomeTabela + ' SET ITE_SALDOS = :SALDOS ');

  qryUpdate.SQL.Add('                              , ITE_SAL_ML  = :SAL_ML ');

  If (cdsSalInv.FindField(strCamPre) <> Nil) And
     (recPreInv.strCodigo <> 'ULTFED') And
     (recPreInv.strCodigo <> 'PRELIQ') Then
  begin

    qryUpdate.SQL.Add(', ' + strCamPre + ' = :CAMPRE');

    If Assigned(fRetornaColunaByFieldName(strCamPre)) Then
      fRetornaColunaByFieldName(strCamPre).Options.Editing := True;
  end;

  qryUpdate.SQL.Add('WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');

  intNumDec := fCfgSis('DECUNI', varInteger);
  TcxCurrencyEditProperties(cxgItensPREVE1.Properties).DisplayFormat := fMskDigitos(intNumDec);
  TcxCurrencyEditProperties(cxgItensPREVE2.Properties).DisplayFormat := fMskDigitos(intNumDec);
  TcxCurrencyEditProperties(cxgItensPREVE3.Properties).DisplayFormat := fMskDigitos(intNumDec);
  TcxCurrencyEditProperties(cxgItensPREVE4.Properties).DisplayFormat := fMskDigitos(intNumDec);
  TcxCurrencyEditProperties(cxgItensPREVE5.Properties).DisplayFormat := fMskDigitos(intNumDec);
  TcxCurrencyEditProperties(cxgItensPREVE6.Properties).DisplayFormat := fMskDigitos(intNumDec);
  TcxCurrencyEditProperties(cxgItensPREVE7.Properties).DisplayFormat := fMskDigitos(intNumDec);
  TcxCurrencyEditProperties(cxgItensPRECOM.Properties).DisplayFormat := fMskDigitos(intNumDec);
  TcxCurrencyEditProperties(cxgItensPRECUS.Properties).DisplayFormat := fMskDigitos(intNumDec);
  TcxCurrencyEditProperties(cxgItensPREMED.Properties).DisplayFormat := fMskDigitos(intNumDec);
  TcxCurrencyEditProperties(cxgItensIMPULT.Properties).DisplayFormat := fMskDigitos(intNumDec);
  TcxCurrencyEditProperties(cxgItensSALDOS.Properties).DisplayFormat := fMskDigitos(3);
  TcxCurrencyEditProperties(cxgItensSALBAL.Properties).DisplayFormat := fMskDigitos(3);
  TcxCurrencyEditProperties(cxgItensSAL_ML.Properties).DisplayFormat := fMskDigitos(3);
  TcxCurrencyEditProperties(cxgItensCNV_ML.Properties).DisplayFormat := fMskDigitos(3);

end;


end.

