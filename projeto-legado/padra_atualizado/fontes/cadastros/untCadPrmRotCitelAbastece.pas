unit untCadPrmRotCitelAbastece;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxGroupBox, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untZClient, cxDBEditRepository,
  untFuncoesSimples, cxDBLookupComboBox, cxEditRepositoryItems, Uni, EditFocus,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus, untGravando, cxProgressBar, cxCheckBox,
  cxDBEdit;

type
  TfrmCadPrmRotCitelAbastece = class(TfrmPaiConfirma)
    grpParametros: TcxGroupBox;
    cxGridDBTableView: TcxGridDBTableViewCitel;
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGridCitel;
    dtsParametros: TDataSource;
    cxGridDBTableViewCODEMP: TcxGridDBColumn;
    cxGridDBTableViewABASTE: TcxGridDBColumn;
    cxGridDBTableViewEMPABA: TcxGridDBColumn;
    cxGridDBTableViewABAMIN: TcxGridDBColumn;
    cxEditRepository: TcxEditRepository;
    cmbSimNao: TcxEditRepositoryLookupComboBoxItem;
    cmbTpEst: TcxEditRepositoryLookupComboBoxItem;
    cmbEmpAba: TcxEditRepositoryComboBoxItem;
    grpEstSegCD: TDBRadioGroup;
    dbDiaSeg: TDBEditFocus;
    dbPctSeg: TDBEditFocus;
    chkCnsPdc: TDBCheckBox;
    pnlQtdIte: TPanel;
    lblQtdIte: TLabel;
    dbQtdIte: TDBEditFocus;
    pnlGerTip: TPanel;
    lblGerTip: TLabel;
    cmbGerTIp: TDBComboBox;
    grpTipSal: TDBRadioGroup;
    btnHelpTipoSaldo: TBitBtnLocked;
    pnlEmp: TPanel;
    lblCodEmp: TLabel;
    dbCodEmp: TDBEditFocus;
    chkCnsPed: TDBCheckBox;
    chkPontoExposicao: TcxDBCheckBox;
    chkDisigu: TDBCheckBox;
    cmbTpEstSal: TcxEditRepositoryLookupComboBoxItem;
    cxGridDBTableViewCNITES: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxGridDBTableViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure btnHlpMediaVendasClick(Sender: TObject);
    procedure btnHelpTipoSaldoClick(Sender: TObject);
    procedure cxGridDBTableViewFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cmbSimNaoPropertiesEditValueChanged(Sender: TObject);
  private
    cdsParametros,
    cdsSimNao,
    cdsTpEst,
    cdsTpEstSal: TZClient;
    blnPonExp: Boolean;
    procedure pCriaCdsTpEst;
    procedure pCriaCdsTpEstSal;
    procedure pConfirma;
    function fConfirma(AStrMensagem: String): Boolean;
    procedure pLerParametros;
    function fGetSQL: String;
    procedure pCriaCdsSimNao;
    function fGetListaEmpAbastecedoras: TStringList;
    procedure pSetarListaEmpresasAbastecedoras;
    function fConfirmarParametrosAux(pgbProgresso: TCxProgressBar): Boolean;
    function fAtualizaParametroEmpresa(AQryUpdate: TUniQuery): Boolean;
    function fCriaQueryUpd: TUniQuery;
    procedure pAfterPost(DataSet: TDataSet);
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pOnChangeAbaste(DataField: TField);
    function fValidaCdsCamposObrigatorios: Boolean;
    procedure pHabilitaCompentesTela(blnHabilita : Boolean);
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public

  end;

var
  frmCadPrmRotCitelAbastece: TfrmCadPrmRotCitelAbastece;

implementation

{$R *.dfm}

{ TfrmCadPrmRotCitelAbastece }

procedure TfrmCadPrmRotCitelAbastece.btnConfirmaClick(Sender: TObject);
begin
  If Not fVerificaCampos Then
    Exit;

  If Not fValidaCdsCamposObrigatorios Then
    Exit;

  pConfirma;
end;

function TfrmCadPrmRotCitelAbastece.fValidaCdsCamposObrigatorios: Boolean;
var
  strCodEmp: String;
begin
  Result := True;
  cdsParametros.First;
  While Not cdsParametros.Eof Do
  Begin
    strCodEmp := cdsParametros.FieldByName('EMP_CODEMP').AsString;
    If cdsParametros.FieldByname('PRM_ABASTE').AsString = 'S' Then
    Begin
      cdsParametros.Next;
      Continue;
    End
    Else
    Begin
      If fEmptyStr(cdsParametros.FieldByName('PRM_EMPABA').AsString) Then
      Begin
        pMensagemOk('Empresa ' + strCodEmp + ': A empresa abastecedora deve ser informada quando a empresa não é abastecedora!');
        cxGridDBTableViewEMPABA.Focused := True;
        Exit(False);
      End;
      If fEmptyStr(cdsParametros.FieldByName('PRM_ABAMIN').AsString) Then
      Begin
        pMensagemOk('Empresa ' + strCodEmp + ': Abastecer pelo mínimo ou pelo máximo deve ser informado quando a empresa não é abastecedora!');
        cxGridDBTableViewABAMIN.Focused := True;
        Exit(False);
      End;
    End;

    cdsParametros.Next;
  End;

  if chkPontoExposicao.Checked then
    pMensagemOk('Se opção "Utilizar regras de ponto de exposição" estiver marcada,'+#13+
                'irá anular opções selecionadas em: "Abastecer pelo minimo ou maximo".');

  If Not Result Then
    cxGridDBTableView.Focused := True;
end;

procedure TfrmCadPrmRotCitelAbastece.btnHelpTipoSaldoClick(Sender: TObject);
begin
  inherited;
  pMensagemOk('O saldo físico não leva em consideração as quantidades reservadas '+ #13#10 +
              'Já o saldo disponível leva em consideração essas quantidades');
end;

procedure TfrmCadPrmRotCitelAbastece.btnHlpMediaVendasClick(Sender: TObject);
begin
  inherited;
  pMensagemOk('A quantidade para garantir os dias de estoque será calculada' + #13#10 +
              'pelas informações fornecidas no grupo "Calcular Vendas Por"' + #13#10 +
              'localizado no canto superior direito dessa tela.');
end;

procedure TfrmCadPrmRotCitelAbastece.cmbSimNaoPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  keybd_event(VK_RETURN, 0, 0, 0);
end;

procedure TfrmCadPrmRotCitelAbastece.cxGridDBTableViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  If Pos(TcxGridDBColumn(AItem).DataBinding.FieldName, 'PRM_ABAMIN_PRM_CNITES_PRM_EMPABA') > 0 Then
    AAllow := cdsParametros.FieldByName('PRM_ABASTE').AsString = 'N';
end;

procedure TfrmCadPrmRotCitelAbastece.cxGridDBTableViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
var
  blnHabilita: Boolean;
begin
  inherited;

  blnHabilita := False;
  if SameText(VarToStr(AFocusedRecord.Values[cxGridDBTableViewABASTE.Index]), 'S')  then
    blnHabilita := True;

  pHabilitaCompentesTela(blnHabilita);
end;

function TfrmCadPrmRotCitelAbastece.fConfirma(AStrMensagem: String): Boolean;
begin
  Result := fMensagem('', AStrMensagem, ['&Sim','&Não']) = 1;
end;

function TfrmCadPrmRotCitelAbastece.fGetListaEmpAbastecedoras: TStringList;
var
  stlEmp: TStringList;
  intRecNo: Integer;
begin
  stlEmp := TStringList.Create;
  intRecNo := cdsParametros.RecNo;

  cdsParametros.First;
  While Not cdsParametros.Eof Do
  Begin
    If cdsParametros.FieldByName('PRM_ABASTE').AsString = 'S' Then
      stlEmp.Add(cdsParametros.FieldByName('EMP_CODEMP').AsString);

    cdsParametros.Next;
  End;

  Result := stlEmp;
  cdsParametros.RecNo := intRecNo;
end;

function TfrmCadPrmRotCitelAbastece.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT                             ';
  Result := Result + '  EMP_CODEMP,                       ';
  Result := Result + '  PRMRCA.AUTOINCREM,                ';
  Result := Result + '  PRM_CODEMP,                       ';
  Result := Result + '  IF(IFNULL(PRM_MANTES,"") = "", "S", PRM_MANTES) AS PRM_MANTES,  ';
  Result := Result + '  IF(IFNULL(PRM_PTOEXP,"") = "", "N", PRM_PTOEXP) AS PRM_PTOEXP,  ';
  Result := Result + '  IF(IFNULL(PRM_ESTSEG,"") = "", "S", PRM_ESTSEG) AS PRM_ESTSEG,  ';
  Result := Result + '  IF(IFNULL(PRM_TIPSAL,"") = "", "F", PRM_TIPSAL) AS PRM_TIPSAL,  ';
  Result := Result + '  IF(IFNULL(PRM_CNSPED,"") = "", "S", PRM_CNSPED) AS PRM_CNSPED,  ';
  Result := Result + '  IF(IFNULL(PRM_CNSPDC,"") = "", "S", PRM_CNSPDC) AS PRM_CNSPDC,  ';
  Result := Result + '  IF(IFNULL(PRM_ABASTE,"S") = "S", "", PRM_ABAMIN) AS PRM_ABAMIN,';
  Result := Result + '  IF(IFNULL(PRM_ABASTE,"S") = "S", "", PRM_EMPABA) AS PRM_EMPABA,  ';
  Result := Result + '  IF(IFNULL(PRM_ABASTE,"") = "", "S", PRM_ABASTE) AS PRM_ABASTE,  ';
  Result := Result + '  PRM_PCTSEG,                                          ';
  Result := Result + '  PRM_DIASEG,                                          ';
  Result := Result + '  IF(IFNULL(PRM_QTDITE,"") = "", 1, PRM_QTDITE) AS PRM_QTDITE,    ';
  Result := Result + '  IF(PRM_GERTIP = "", "GRUPO DE PRODUTO", PRM_GERTIP) AS PRM_GERTIP ';
  Result := Result + '  ,IFNULL(PRM_DISIGU,"N") AS PRM_DISIGU, ';
  Result := Result + '  IF(IFNULL(PRM_ABASTE,"S") = "S", "", PRM_CNITES) AS PRM_CNITES';
  Result := Result + ' FROM                               ';
  Result := Result + '  CADEMP                            ';
  Result := Result + ' LEFT JOIN PRMRCA ON                ';
  Result := Result + '  PRMRCA.PRM_CODEMP = EMP_CODEMP    ';
  Result := Result + ' WHERE EMP_UTIABA = "S"             ';
end;

procedure TfrmCadPrmRotCitelAbastece.FormCreate(Sender: TObject);
begin
  inherited;
  cdsParametros := TZClient.Create(Self);
  cdsParametros.AfterPost := pAfterPost;
  cdsParametros.AfterScroll := pAfterScroll;
  dtsParametros.DataSet := cdsParametros;

  pLerParametros;

  pCriaCdsSimNao;
  pCriaCdsTpEst;
  pCriaCdsTpEstSal;

  blnPonExp := fCfgSis('PONEXP', varBoolean);
  chkPontoExposicao.Visible := blnPonExp;
end;

procedure TfrmCadPrmRotCitelAbastece.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsTpEst);
  FreeAndNil(cdsSimNao);
  FreeAndNil(cdsParametros);
  FreeAndNil(cdsTpEstSal);
end;

function TfrmCadPrmRotCitelAbastece.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If Not (cdsParametros.State = dsEdit) Then
      cdsParametros.Edit;

    If (Sender = dbPctSeg) Then
    Begin

      If fEmptyStr(dbPctSeg.Text) Then
        dbPctSeg.Field.Value := '0,00'

      Else If fStrToFloat(dbPctSeg.Text) < 0 Then
      Begin
        pMensagemOk('Informe um percentual maior ou igual a zero!');
        Result := False;
      End;

    End
    Else If (Sender = dbDiaSeg) Then
    Begin

      If fEmptyStr(dbDiaSeg.Text) Then
        dbDiaSeg.Field.Value := '0'

      Else If fStrToFloat(dbDiaSeg.Text) < 0 Then
      Begin
        pMensagemOk('Dias de Estoque deve ser maior ou igual a zero!');
        Result := False;
      End;

    End
    Else If (Sender = dbQtdIte) Then
    Begin

      If fEmptyStr(dbQtdIte.Text) Then
        dbQtdIte.Field.Value := '0'

      Else If fStrToFloat(dbQtdIte.Text) < 1 Then
      Begin
        pMensagemOk('Quantidade de itens por pedido deve ser maior ou igual a 1!');
        Result := False;
      End;

    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadPrmRotCitelAbastece.pAfterPost(DataSet: TDataSet);
begin
  pSetarListaEmpresasAbastecedoras;
end;

procedure TfrmCadPrmRotCitelAbastece.pAfterScroll(DataSet: TDataSet);
begin
  chkPontoExposicao.Visible := blnPonExp And (DataSet.FieldByName('PRM_ABASTE').AsString = 'N');
  If Not chkPontoExposicao.Visible Then
    chkPontoExposicao.Checked := False;
end;

procedure TfrmCadPrmRotCitelAbastece.pConfirma;
begin
  If Not fConfirma('Confirma parâmetros?') Then
    Exit;

  If Not TFrmGravando.fExecutarModalA(fConfirmarParametrosAux, 'Atualizando parâmetros...', '') Then
    pMensagemOk('Erro ao atualizar os parâmetros')
  Else
    ModalResult := mrOk;
end;

function TfrmCadPrmRotCitelAbastece.fCriaQueryUpd: TUniQuery;
begin
  Result := fCriaQuery;
  Result.SQL.Clear;
  Result.SQL.Add(' INSERT INTO PRMRCA (AUTOINCREM, ');
  Result.SQL.Add('                     PRM_CODEMP, ');
  Result.SQL.Add('                     PRM_MANTES, ');
  Result.SQL.Add('                     PRM_ESTSEG, ');
  Result.SQL.Add('                     PRM_TIPSAL, ');
  Result.SQL.Add('                     PRM_CNSPED, ');
  Result.SQL.Add('                     PRM_CNSPDC, ');
  Result.SQL.Add('                     PRM_ABAMIN, ');
  Result.SQL.Add('                     PRM_EMPABA, ');
  Result.SQL.Add('                     PRM_ABASTE, ');
  Result.SQL.Add('                     PRM_PCTSEG, ');
  Result.SQL.Add('                     PRM_DIASEG, ');
  Result.SQL.Add('                     PRM_QTDITE, ');
  Result.SQL.Add('                     PRM_PTOEXP, ');
  Result.SQL.Add('                     PRM_DISIGU, ');
  Result.SQL.Add('                     PRM_GERTIP, ');
  Result.SQL.Add('                     PRM_DTACAD, ');
  Result.SQL.Add('                     PRM_HRACAD, ');
  Result.SQL.Add('                     PRM_OPECAD, ');
  Result.SQL.Add('                     PRM_CNITES) ');
  Result.SQL.Add('             VALUES(:AUTOINCREM, ');
  Result.SQL.Add('                    :PRM_CODEMP, ');
  Result.SQL.Add('                    :PRM_MANTES, ');
  Result.SQL.Add('                    :PRM_ESTSEG, ');
  Result.SQL.Add('                    :PRM_TIPSAL, ');
  Result.SQL.Add('                    :PRM_CNSPED, ');
  Result.SQL.Add('                    :PRM_CNSPDC, ');
  Result.SQL.Add('                    :PRM_ABAMIN, ');
  Result.SQL.Add('                    :PRM_EMPABA, ');
  Result.SQL.Add('                    :PRM_ABASTE, ');
  Result.SQL.Add('                    :PRM_PCTSEG, ');
  Result.SQL.Add('                    :PRM_DIASEG, ');
  Result.SQL.Add('                    :PRM_QTDITE, ');
  Result.SQL.Add('                    :PRM_PTOEXP, ');
  Result.SQL.Add('                    :PRM_DISIGU, ');
  Result.SQL.Add('                    :PRM_GERTIP, ');
  Result.SQL.Add('                    :PRM_DTACAD, ');
  Result.SQL.Add('                    :PRM_HRACAD, ');
  Result.SQL.Add('                    :PRM_OPECAD, ');
  Result.SQL.Add('                    :PRM_CNITES) ');
end;

function TfrmCadPrmRotCitelAbastece.fConfirmarParametrosAux(pgbProgresso: TCxProgressBar): Boolean;
var
  qryUpd: TUniQuery;
begin
  Result := False;
  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := cdsParametros.RecordCount;

  qryUpd := fCriaQueryUpd;

  Try
    cdsParametros.First;
    fStartTransaction;
    While Not cdsParametros.Eof Do
    Begin
      If Not fAtualizaParametroEmpresa(qryUpd) Then
        Exit(False);

      pgbProgresso.Position := pgbProgresso.Position + 1;
      cdsParametros.Next;
    End;

    Try
      fCommit;
      pMensagemOk('Parâmetros salvos com sucesso');
      Result := True;
    Except On
      E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, 'TfrmcadPrmRotCitelAbastece.fConfirmarParametrosAux');
      End;
    End;
  Finally
    FreeAndNil(qryUpd);
  End;
end;

function TfrmCadPrmRotCitelAbastece.fAtualizaParametroEmpresa(AQryUpdate: TUniQuery): Boolean;
begin
  Try
    If Not fEmptyStr(cdsParametros.FieldByName('AUTOINCREM').AsString) Then
      untFuncoesSimples.fExecutaSQL('DELETE FROM PRMRCA WHERE AUTOINCREM = ' + QuotedStr(cdsParametros.FieldByName('AUTOINCREM').AsString));

    AQryUpdate.ParamByName('AUTOINCREM').AsString  := fRetAutoIncrem('PRMRCA', VS_strCodEmp);
    AQryUpdate.ParamByName('PRM_CODEMP').AsString  := cdsParametros.FieldByName('EMP_CODEMP').AsString;
    AQryUpdate.ParamByName('PRM_MANTES').AsString  := cdsParametros.FieldByName('PRM_MANTES').AsString;
    AQryUpdate.ParamByName('PRM_ESTSEG').AsString  := cdsParametros.FieldByName('PRM_ESTSEG').AsString;
    AQryUpdate.ParamByName('PRM_TIPSAL').AsString  := cdsParametros.FieldByName('PRM_TIPSAL').AsString;
    AQryUpdate.ParamByName('PRM_CNSPED').AsString  := cdsParametros.FieldByName('PRM_CNSPED').AsString;
    AQryUpdate.ParamByName('PRM_CNSPDC').AsString  := cdsParametros.FieldByName('PRM_CNSPDC').AsString;
    AQryUpdate.ParamByName('PRM_ABAMIN').AsString  := cdsParametros.FieldByName('PRM_ABAMIN').AsString;
    AQryUpdate.ParamByName('PRM_DTACAD').AsDateTime:= fNow;
    AQryUpdate.ParamByName('PRM_HRACAD').AsDateTime:= fTime;
    AQryUpdate.ParamByName('PRM_OPECAD').AsString  := strLoginUsuarioLogado;

    If fEmptyStr(cdsParametros.FieldByName('PRM_EMPABA').AsString) Then
      AQryUpdate.ParamByName('PRM_EMPABA').Clear
    Else
      AQryUpdate.ParamByName('PRM_EMPABA').AsString  := cdsParametros.FieldByName('PRM_EMPABA').AsString;

    AQryUpdate.ParamByName('PRM_ABASTE').AsString  := cdsParametros.FieldByName('PRM_ABASTE').AsString;
    AQryUpdate.ParamByName('PRM_PCTSEG').AsFloat   := cdsParametros.FieldByName('PRM_PCTSEG').AsFloat;
    AQryUpdate.ParamByName('PRM_DIASEG').AsInteger := cdsParametros.FieldByName('PRM_DIASEG').AsInteger;
    AQryUpdate.ParamByName('PRM_QTDITE').AsInteger := cdsParametros.FieldByName('PRM_QTDITE').AsInteger;
    AQryUpdate.ParamByName('PRM_GERTIP').AsString  := cdsParametros.FieldByName('PRM_GERTIP').AsString;
    AQryUpdate.ParamByName('PRM_DISIGU').AsString  := cdsParametros.FieldByName('PRM_DISIGU').AsString;
    AQryUpdate.ParamByName('PRM_CNITES').AsString  := cdsParametros.FieldByName('PRM_CNITES').AsString;

    if fCfgSis('PONEXP', varBoolean) then
      AQryUpdate.ParamByName('PRM_PTOEXP').AsString := cdsParametros.FieldByName('PRM_PTOEXP').AsString
    else
      AQryUpdate.ParamByName('PRM_PTOEXP').AsString := 'N';

    AQryUpdate.ExecSQL;
    Result := True;
  Except On
    E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TfrmCadPrmRotCitelAbastece.fAtualizaParametroEmpresa');
    End;
  End;
end;

procedure TfrmCadPrmRotCitelAbastece.pCriaCdsTpEst;
begin
  cdsTpEst := TZClient.Create(Self, 'SELECT "MIN" AS VALCAM, "Mínimo" AS DESCAM UNION '+
                                    'SELECT "MAX" AS VALCAM, "Máximo" AS DESCAM ');

  cdsTpEst.fLeDados('TfrmCadPrmRotCitelAbastece.pCriaCdsTpEst');

  TcxLookupComboBoxProperties(cmbTpEst.Properties).ListSource := cdsTpEst.dtsSource;
end;

procedure TfrmCadPrmRotCitelAbastece.pCriaCdsTpEstSal;
begin
  cdsTpEstSal := TZClient.Create(Self, 'SELECT "MEN" AS VALCAM, "Menor que estoque Mínimo"   AS DESCAM UNION '+
                                       'SELECT "MIG" AS VALCAM, "Menor ou igual ao estoque Mínimo" AS DESCAM');

  cdsTpEstSal.fLeDados('TfrmCadPrmRotCitelAbastece.pCriaCdsTpEstSal');

  TcxLookupComboBoxProperties(cmbTpEstSal.Properties).ListSource := cdsTpEstSal.dtsSource;
end;

procedure TfrmCadPrmRotCitelAbastece.pHabilitaCompentesTela(
  blnHabilita: Boolean);
begin
  grpEstSegCD.Enabled := blnHabilita;
  grpTipSal.Enabled := blnHabilita;
  chkCnsPed.Enabled := blnHabilita;
  chkCnsPdc.Enabled := blnHabilita;
  chkDisigu.Enabled := blnHabilita;
  cmbGerTIp.Enabled := blnHabilita;
  dbQtdIte.Enabled := blnHabilita;
  chkPontoExposicao.Enabled := blnHabilita;
end;

procedure TfrmCadPrmRotCitelAbastece.pCriaCdsSimNao;
Begin
  cdsSimNao := TZClient.Create(Self, 'SELECT "S" AS VALCAM, "Sim" AS DESCAM UNION ' +
                                     'SELECT "N" AS VALCAM, "Não" AS DESCAM');
  cdsSimNao.fLeDados('TfrmCadPrmRotCitelAbastece.pCriaCdsSimNao');

  TcxLookupComboBoxProperties(cmbSimNao.Properties).ListSource := cdsSimNao.dtsSource;
End;

procedure TfrmCadPrmRotCitelAbastece.pLerParametros;
begin
  Try
    cdsParametros.qryQuery.SQL.Clear;
    cdsParametros.qryQuery.SQL.Add(fGetSQL);
    cdsParametros.fAbreClient(True, 'TfrmCadPrmRotCitelAbastece.pLerParametros');
    pSetarListaEmpresasAbastecedoras;

    cdsParametros.FieldByName('PRM_ABASTE').OnChange := pOnChangeAbaste;
  Except On
    E:Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmFatSelPedidoCompraRequisicao.pConfirma');
    End;
  End;
end;

procedure TfrmCadPrmRotCitelAbastece.pOnChangeAbaste(DataField: TField);
var
  blnHabilita: Boolean;
begin
  inherited;
  If DataField.FieldName = 'PRM_ABASTE' Then
  Begin
    blnHabilita := DataField.AsString = 'S';
    pHabilitaCompentesTela(blnHabilita);
    If blnHabilita Then
    Begin
      cdsParametros.FieldByName('PRM_EMPABA').Clear;
      cdsParametros.FieldByName('PRM_ABAMIN').Clear;
      cdsParametros.FieldByName('PRM_CNITES').Clear;
    End;
  End;
end;

procedure TfrmCadPrmRotCitelAbastece.pSetarListaEmpresasAbastecedoras;
begin
  cmbEmpAba.Properties.Items.Clear;
  cmbEmpAba.Properties.Items := fGetListaEmpAbastecedoras;
end;

end.
