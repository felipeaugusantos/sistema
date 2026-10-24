{***********************}
{* qryConCli -> CADCLI *}
{********************JB*}

unit untTransfCodCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, untPaiTransfCod, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, ComCtrls,
  AppEvnts, Uni, UniClientDataSet, strUtils, DB,
  BitBtnLockedIncrem, cxProgressBar, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxButtons, untTransfImportAutomatico,
  untZClient, untMostraDebCtrChq2;

type
  TForeignKey = Record
    strCampoOri: String;
    strTabela  : String;
    strCampoRel: String;
End;

type
  TForeignKeyArray = Array of TForeignKey;  

type
  TSeqEntCli = (secSeqInd, secSeqVis);

Type
  TCamposCliente = record
    strNomArq: String;
    strDesCam: String;
    strCamCod: String;

  End;

type
  TfrmTransfCodCliente = class(TfrmPaiTransfCod)
    pnlCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtCliOri: TEditFocus;
    edtDesCliOri: TEditFocus;
    edtCliDes: TEditFocus;
    edtDesCliDes: TEditFocus;
    lsvArqAlterados: TListView;
    btnConfirmaDados: TBitBtnLocked;
    frxReport: TfrxReport;
    btnImpExcel: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure edtCliOriKeyPress(Sender: TObject; var Key: Char);
    procedure edtCliDesKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure edtCliOriExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnImpExcelClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
  private
    { Private declarations }
    qryConCli: TUniQuery;
    arrCamposCliente: Array Of TCamposCliente;

    objExcelTrans: TTransfImportAutomatico;
    cdsCliente: TZClient;
    blnDivergencia: Boolean;

    procedure pCarregaCliOri;
    procedure pCarregaCliDes;

    function fIgnorarCampo(strTabela, strCampo: String): Boolean;    
    function fTransfereCodCliente: Boolean;
    function fAtualizaCodCliente(strNomArq, strCampo, strCliOri, strCliDes: String; intOpcao: Integer): Integer;

    procedure pCriaClientCliente;
    procedure pMostraDivergencia;
    procedure pCriaForm;
    procedure pGravaLogChq(strTabela, strCliOri, strCliDes: String);
    procedure pPreencheArray(pgbProgresso: TCxProgressBar);
    function fChecarTabelas(pgbProgresso: TCxProgressBar): Boolean;
    procedure pRegistraProgresso(pbProgress: TCxProgressBar; strMsg: String; intPos, intMax: Integer);
    Procedure pAtualizaDadosCliente;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmTransfCodCliente: TfrmTransfCodCliente;

implementation

uses untfuncoesSimples, untPesqAux, untConsultas, untCfgRepositorio,
     untFuncoesAuxiliares, untGravando, untTCadChqRepository, untModulo;

const
  MSG_VALID_FOREIGN_KEY = 'Validando Chave Estrangeira do Banco de Dados. Aguarde...';

{$R *.dfm}

procedure TfrmTransfCodCliente.FormCreate(Sender: TObject);
begin
  inherited;
  blnDivergencia := True;
  qryConCli := fCriaQuery;
  objExcelTrans := TTransfImportAutomatico.Create;
end;

procedure TfrmTransfCodCliente.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryConCli);
  FreeAndNil(objExcelTrans);
end;

procedure TfrmTransfCodCliente.edtCliOriKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCliOri, edtDesCliOri, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCliOri, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTransfCodCliente.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxReport);
end;

procedure TfrmTransfCodCliente.btnImpExcelClick(Sender: TObject);
begin
  inherited;
  objExcelTrans.pAddEditInput(edtCliOri, 8, True);
  objExcelTrans.pAddEditInput(edtCliDes, 8, True);
  objExcelTrans.pEventoQueTransfere := btnConfirmaDados.OnClick;
  objExcelTrans.fExecutar;
end;

procedure TfrmTransfCodCliente.edtCliDesKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCliDes, edtDesCliDes, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCliDes, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmTransfCodCliente.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtCliOri) Then
  Begin

    If (fEmptyStr(edtCliOri.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O cliente origem deve ser preenchido!');
      Result := False;
    End
    Else If edtCliOri.Text = edtCliDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O cliente origem deve diferente do cliente destino!');
      Result := False;
    End
    Else
    Begin
      pCarregaCliOri;
      If (fEmptyStr(edtDesCliOri.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse cliente não está cadastrado!');
        Result := False;
      End
      Else If (qryConCli.FieldByName('CLI_STATUS').AsString = 'I') Then
      Begin
        objExcelTrans.pAddNotificacao('Esse cliente está inativo!');
        Result := False;
      End
      Else If (qryConCli.FieldByName('CLI_STATUS').AsString = 'B') Then
      Begin
        objExcelTrans.pAddNotificacao('Esse cliente está bloqueado!');
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtCliDes) Then
  Begin

    If (fEmptyStr(edtCliDes.Text)) Then
    Begin
      objExcelTrans.pAddNotificacao('O cliente destino deve ser preenchido!');
      Result := False;
    End
    Else If edtCliOri.Text = edtCliDes.Text Then
    Begin
      objExcelTrans.pAddNotificacao('O cliente destino deve diferente do cliente origem!');
      Result := False;
    End
    Else
    Begin
      pCarregaCliDes;
      If (fEmptyStr(edtDesCliDes.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Esse cliente não está cadastrado!');
        Result := False;
      End
      Else If (qryConCli.FieldByName('CLI_STATUS').AsString = 'I') Then
      Begin
        objExcelTrans.pAddNotificacao('Esse cliente está inativo!');
        Result := False;
      End;
    End;

  End;


end;

procedure TfrmTransfCodCliente.pCarregaCliDes;
begin

  pPesquisaCadCli(qryConCli, qryConCli, edtCliDes.Text);
  With qryConCli Do
  Begin
    edtDesCliDes.Text := FieldByName('CLI_NOMCLI').AsString;
  End;


end;

procedure TfrmTransfCodCliente.pCarregaCliOri;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCliOri.Text);
  With qryConCli Do
  Begin
    edtDesCliOri.Text := FieldByName('CLI_NOMCLI').AsString;
  End;
end;

function TfrmTransfCodCliente.fIgnorarCampo(strTabela, strCampo: String): Boolean;
begin
  Result := ((strTabela = 'CADFIC')     And (strCampo = 'FIC_CODCLI')) Or
            ((strTabela = 'CADCLI')     And (strCampo = 'CLI_CODCLI')) Or
            ((strTabela = 'CLI_INFCRE') And (strCampo = 'CLI_CODCLI'));
end;

Procedure TfrmTransfCodCliente.pAtualizaDadosCliente;
  Var
    qryCliOri,
    qryCliDes,
    qryExec: TUniQuery;


    Function fSQLDados: String;
    Begin
      Result := '';
      Result := Result + ' SELECT   ';
      Result := Result + '   CLI_CODCLI, ';

      Result := Result + '   CLI_DOMCOM, ';
      Result := Result + '   CLI_DTMCOM, ';
      Result := Result + '   CLI_VRMCOM, ';

      Result := Result + '   CLI_DOUCOM, ';
      Result := Result + '   CLI_ULTCOM, ';
      Result := Result + '   CLI_VRUCOM   ';

      Result := Result + ' FROM     ';
      Result := Result + '   CADCLI ';
      Result := Result + ' WHERE    ';
      Result := Result + '   CLI_CODCLI = :CODCLI ';
    End;

Begin
  qryCliOri := fCriaQuery;
  qryCliDes := fCriaQuery;
  qryExec   := fCriaQuery;

  qryCliOri.SQL.Text := fSQLDados;
  qryCliDes.SQL.Text := fSQLDados;

  qryCliOri.ParamByName('CODCLI').AsString := edtCliOri.Text;
  qryCliOri.Open;

  qryCliDes.ParamByName('CODCLI').AsString := edtCliDes.Text;
  qryCliDes.Open;

  If qryCliOri.FieldByName('CLI_VRMCOM').Value > qryCliDes.FieldByName('CLI_VRMCOM').Value Then
  Begin
    qryExec.SQL.Clear;
    qryExec.SQL.Add('UPDATE CADCLI SET');
    qryExec.SQL.Add('       CLI_VRMCOM = :CLI_VRMCOM,');
    qryExec.SQL.Add('       CLI_DOMCOM = :CLI_DOMCOM,');
    qryExec.SQL.Add('       CLI_DTMCOM = :CLI_DTMCOM');
    qryExec.SQL.Add(' WHERE CLI_CODCLI = :CLIDES');
    qryExec.ParamByName('CLI_VRMCOM').Value := qryCliOri.FieldByName('CLI_VRMCOM').Value;
    qryExec.ParamByName('CLI_DOMCOM').Value := qryCliOri.FieldByName('CLI_DOMCOM').Value;
    qryExec.ParamByName('CLI_DTMCOM').Value := qryCliOri.FieldByName('CLI_DTMCOM').Value;
    qryExec.ParamByName('CLIDES').Value :=  edtCliDes.Text;
    qryExec.ExecSQL;
  End;

  If qryCliOri.FieldByName('CLI_DOUCOM').Value > qryCliDes.FieldByName('CLI_DOUCOM').Value Then
  Begin
    qryExec.SQL.Clear;
    qryExec.SQL.Add('UPDATE CADCLI SET');
    qryExec.SQL.Add('       CLI_DOUCOM = :CLI_DOUCOM,');
    qryExec.SQL.Add('       CLI_ULTCOM = :CLI_ULTCOM,');
    qryExec.SQL.Add('       CLI_VRUCOM = :CLI_VRUCOM');
    qryExec.SQL.Add(' WHERE CLI_CODCLI = :CLIDES;');

    qryExec.ParamByName('CLI_DOUCOM').Value := qryCliOri.FieldByName('CLI_DOUCOM').Value;
    qryExec.ParamByName('CLI_ULTCOM').Value := qryCliOri.FieldByName('CLI_ULTCOM').Value;
    qryExec.ParamByName('CLI_VRUCOM').Value := qryCliOri.FieldByName('CLI_VRUCOM').Value;
    qryExec.ParamByName('CLIDES').Value := edtCliDes.Text;
    qryExec.ExecSQL;
  End;

  FreeAndNil(qryCliOri);
  FreeAndNil(qryCliDes);
  FreeAndNil(qryExec);
End;

function TfrmTransfCodCliente.fTransfereCodCliente: Boolean;
  Var
    intContador    : Integer;
    intContador2   : Integer;
    intTamMat      : Integer;
    intRegAlterados: Integer;
    strSQL         : String;
    qryGenCli      : TUniQuery;
begin
  Try

    qryGenCli := fCriaQuery(Self);

    intTamMat := Length(arrCamposCliente);
    intContador := 0;

    Try

      While intContador < intTamMat Do
      Begin

        lsvArqAlterados.Items.Add;
        lsvArqAlterados.Items[intContador].Caption := arrCamposCliente[intContador].strDesCam;
        lsvArqAlterados.Items[intContador].SubItems.Add('Processando...');
        Inc(intContador);
        Application.ProcessMessages;

      End;

      intContador := 0;
      fStartTransaction;
      pAtualizaDadosCliente;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADFIC WHERE FIC_CODCLI = :CLIORI ';

      With qryGenCli Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CLIORI').AsString := edtCliOri.Text;
        ExecSQL;
        Close;
      End;

      //Deleta as condições de pagamento que consincidem, para não dar erro de Chave Única.
      strSQL := '';
      strSQL := strSQL + ' SELECT * FROM CLICND ';
      strSQL := strSQL + ' WHERE CND_CODCLI = :CLIORI ';
      strSQL := strSQL + ' AND CND_CODCND IN (SELECT CND_CODCND FROM CLICND WHERE CND_CODCLI = :CLIDES) ';
      With qryGenCli Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CLIORI').AsString := edtCliOri.Text;
        ParamByName('CLIDES').AsString := edtCliDes.Text;
        Open;
        First;

        While not EOF Do
          Delete;

        Close;
      End;

      While intContador < intTamMat Do
      Begin

        If Pos(arrCamposCliente[intContador].strNomArq, 'CADCHQ') > 0 Then
          pGravaLogChq(arrCamposCliente[intContador].strNomArq, edtCliOri.Text, edtCliDes.Text);


        Application.ProcessMessages;
        intRegAlterados := 0;

        For intContador2 := 1 To 2 Do
        Begin

          intRegAlterados := intRegAlterados + fAtualizaCodCliente(arrCamposCliente[intContador].strNomArq,
                                                                   arrCamposCliente[intContador].strCamCod,
                                                                   edtCliOri.Text,
                                                                   edtCliDes.Text,
                                                                   intContador2);

          Application.ProcessMessages;

        End;
        lsvArqAlterados.Items[intContador].Selected := True;
        lsvArqAlterados.Items[intContador].MakeVisible(False);
        lsvArqAlterados.Items[intContador].SubItems[0] := IntToStr(intRegAlterados);

        Application.ProcessMessages;
        Inc(intContador);

      End;

      {*************************************************}
      {*  DELETA CADCLI                          *******}
      {*************************************************}
      strSQL := '';
      strSQL := strSQL + 'SELECT * FROM CADCLI WHERE CLI_CODCLI = :CLIORI ';

      With qryGenCli Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CLIORI').AsString := edtCliOri.Text;
        Open;
        fVerificaIntegridade(Self.Name, 'CADCLI', qryGenCli, True);
        Close;
      End;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADCLI WHERE CLI_CODCLI = :CLIORI ';
      With qryGenCli Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CLIORI').AsString := edtCliOri.Text;
        ExecSQL;
        Close;
      End;

      {*************************************************}
      {*  DELETA CLI_INFCRE                      *******}
      {*************************************************}
      strSQL := '';
      strSQL := strSQL + 'SELECT * FROM CLI_INFCRE WHERE CLI_CODCLI = :CLIORI ';

      With qryGenCli Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CLIORI').AsString := edtCliOri.Text;
        Open;
        fVerificaIntegridade(Self.Name, 'CLI_INFCRE', qryGenCli, True);
        Close;
      End;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CLI_INFCRE WHERE CLI_CODCLI = :CLIORI ';

      With qryGenCli Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CLIORI').AsString := edtCliOri.Text;
        ExecSQL;
        Close;
      End;

      {*************************************************}
      {*  DELETA CADFIC                          *******}
      {*************************************************}
      strSQL := '';
      strSQL := strSQL + 'SELECT * FROM CADFIC WHERE FIC_CODCLI = :CLIORI ';

      With qryGenCli Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CLIORI').AsString := edtCliOri.Text;
        Open;
        fVerificaIntegridade(Self.Name, 'CADFIC', qryGenCli, True);
        Close;
      End;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADFIC WHERE FIC_CODCLI = :CLIORI ';

      With qryGenCli Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CLIORI').AsString := edtCliOri.Text;
        ExecSQL;
        Close;
      End;

      {*************************************************}
      {*  DELETA CLIVEI                          *******}
      {*************************************************}

      strSQL := '';
      strSQL := strSQL + 'SELECT * FROM CLIVEI WHERE CLI_CODCLI = :CLIORI ';
      With qryGenCli Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CLIORI').AsString := edtCliOri.Text;
        Open;
        fVerificaIntegridade(Self.Name, 'CLIVEI', qryGenCli, True);
        Close;
      End;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CLIVEI WHERE CLI_CODCLI = :CLIORI ';

      With qryGenCli Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CLIORI').AsString := edtCliOri.Text;
        ExecSQL;
        Close;
      End;


      pGravarTabelaLog(edtCliOri.Text, edtCliDes.Text, 'CADCLI');

      fCommit;
      Result := True;

    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        If objExcelTrans.blnExecutandoTransferencia Then
          objExcelTrans.pAddNotificacao(E.Message)
        Else
          pMensagensErro(E.Message, '[fTransfereCodCliente]');
      End;
    End;

  Finally
    FreeAndNil(qryGenCli);
  End;

end;

{*****************************************}
{* OPÇÃO:                                *}
{* 1 -> ARQUIVO                          *}
{* 3 -> ARQUIVO DELETADO                 *}
{**************************************MV*}

function TfrmTransfCodCliente.fAtualizaCodCliente(strNomArq, strCampo, strCliOri, strCliDes: String;
  intOpcao: Integer): Integer;
  Var
    strSQL   : String;
    strCFG   : String;
    qryTmp,
    qryGenTmp: TUniQuery;
    intSeqInd: Integer;
    intSeqVis: Integer;

  function fGetUltimoSeqIndEndEntrega(tpTipoSeq: TSeqEntCli): Integer;
  Begin
    Result := 0;
    
    strSQL := '';
    strSQL := strSQL + ' SELECT ';

    If tpTipoSeq = secSeqInd Then
      strSQL := strSQL + '   MAX(ETC_SEQIND) AS MAXSEQ '
    Else
      strSQL := strSQL + '   MAX(ETC_SEQVIS) AS MAXSEQ ';

    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + strNomArq;
    strSQL := strSQL + ' WHERE ETC_CODCLI = :CLIDES ';

    With qryGenTmp, SQL Do
    Begin
      Close;
      Clear;
      Add(strSQL);
      ParamByName('CLIDES').AsString := strCliDes;
      Open;

      If Not IsEmpty Then
      Begin
        If Not fEmptyStr(FieldByName('MAXSEQ').AsString) Then
          Result := FieldByName('MAXSEQ').AsInteger + 1;
      End;

      Close;
    End;
  End;

  procedure pGetEnderecosEntregaCliOri;
  Begin
    With qryGenTmp Do
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   * ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + strNomArq;
      strSQL := strSQL + ' WHERE ETC_CODCLI = :CLIORI ';
      
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CLIORI').AsString := strCliOri;
      Open;
    End;
  End;

  procedure pTransVeiCliOri;
  Begin
    Try
      qryTmp := fCriaQuery(Self);

      With qryGenTmp Do
      Begin
        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   * ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + strNomArq + ' A ';
        strSQL := strSQL + ' WHERE A.CLI_CODCLI = :CLIORI ';
        strSQL := strSQL + ' AND (SELECT COUNT(*) FROM '+strNomArq+' B '+'WHERE B.CLI_CODCLI=:CLIDES AND B.CLI_PLAVEI=A.CLI_PLAVEI) = 0';

        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CLIORI').AsString := strCliOri;
        ParamByName('CLIDES').AsString := strCliDes;
        Open;
      End;

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  ' + strNomArq + ' ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  ' + strCampo + ' = :CLIDES ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  ' + strCampo + ' = :CLIORI ';
      strSQL := strSQL + ' AND CLI_PLAVEI = :CLIPLA ';

      With qryTmp Do
      Begin
        SQL.Clear;
        SQL.Add(strSQL);

        qryGenTmp.First;
        While Not qryGenTmp.Eof Do
        Begin
          Close;
          ParamByName('CLIDES').AsString := strCliDes;
          ParamByName('CLIORI').AsString := qryGenTmp.FieldByName('CLI_CODCLI').AsString;
          ParamByName('CLIPLA').AsString := qryGenTmp.FieldByName('CLI_PLAVEI').AsString;
          ExecSQL;
          Result := Result + RowsAffected;

          qryGenTmp.Next;
        End;
      End;
    Finally
      FreeAndNil(qryTmp);
    End;

  End;

  procedure pTransfCliDiv;
  Begin
    Try
      qryTmp := fCriaQuery(Self);

      With qryGenTmp Do
      Begin
        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   * ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + strNomArq + ' A ';
        strSQL := strSQL + ' WHERE A.DIV_CODCLI = :CLIORI';
        strSQL := strSQL + '    AND (SELECT COUNT(*) FROM ' + strNomArq + ' B WHERE B.DIV_CODCLI= :CLIDES AND B.DIV_CODDIV = A.DIV_CODDIV) = 0';

        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CLIORI').AsString := strCliOri;
        ParamByName('CLIDES').AsString := strCliDes;
        Open;
      End;

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  ' + strNomArq + ' ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  ' + strCampo + ' = :CLIDES ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  ' + strCampo + ' = :CLIORI ';
      strSQL := strSQL + ' AND DIV_CODDIV = :CODDIV ';

      With qryTmp Do
      Begin
        SQL.Clear;
        SQL.Add(strSQL);

        qryGenTmp.First;
        While Not qryGenTmp.Eof Do
        Begin
          Close;
          ParamByName('CLIDES').AsString := strCliDes;
          ParamByName('CLIORI').AsString := qryGenTmp.FieldByName('DIV_CODCLI').AsString;
          ParamByName('CODDIV').AsString := qryGenTmp.FieldByName('DIV_CODDIV').AsString;
          ExecSQL;
          Result := Result + RowsAffected;

          qryGenTmp.Next;
        End;
      End;

      strSQL := ' DELETE FROM ' + strNomArq + ' WHERE ' + strCampo + ' = :CLIORI ';

      With qryTmp Do
      Begin
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CLIORI').AsString := strCliOri;
        ExecSQL;
      End;
    Finally
      FreeAndNil(qryTmp);
    End;
  End;

  function fInsertEnderecoEntregaCliDes: Integer;
  Begin
    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  ' + strNomArq + ' ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  ' + strCampo + ' = :CLIDES , ';

    If intSeqInd = 0 Then
      strSQL := strSQL + '  ETC_SEQIND = ' + intToStr(intSeqInd) + ' , '
    Else
      strSQL := strSQL + '  ETC_SEQIND = ETC_SEQIND + ' + intToStr(intSeqInd) + ' , ';

    If intSeqVis = 0 Then
      strSQL := strSQL + '  ETC_SEQVIS = ' + intToStr(intSeqVis) + ' , '
    Else
      strSQL := strSQL + '  ETC_SEQVIS = ETC_SEQVIS + ' + intToStr(intSeqVis) + ' , ';

    strSQL := strSQL + '  ETC_ENDFAT = "N" ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ' + strCampo + ' = :CLIORI ';

    Try
      qryTmp := fCriaQuery(Self);

      With qryTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CLIDES').AsString := strCliDes;
        ParamByName('CLIORI').AsString := strCliOri;
        ExecSQL;
        Result := RowsAffected;

        If Result > 0 Then
        Begin
          Inc(intSeqInd);
          Inc(intSeqVis);
        End;

        Close;
      End;
    Finally
      FreeAndNil(qryTmp);
    End;
  End;

  function fTransfereEmpresaArmazem: Integer;
    Var
      strEmpresas: String;
  Begin
    Try
      strEmpresas := EmptyStr;

      qryTmp := fCriaQuery(Self);

      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   MSA_CODEMP ';
      strSQL := strSQL + ' FROM '+strNomArq+' ';
      strSQL := strSQL + ' WHERE '+strCampo+' = :CLIDES ';

      qryGenTmp.SQL.Clear;
      qryGenTmp.SQL.Add(strSQL);
      qryGenTmp.ParamByName('CLIDES').AsString := strCliDes;
      qryGenTmp.Open;

      While Not qryGenTmp.Eof Do
      Begin
        pIncrementaListaStr(qryGenTmp.FieldByName('MSA_CODEMP').AsString, strEmpresas, True);
        qryGenTmp.Next;
      End;

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  ' + strNomArq + ' ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  ' + strCampo + ' = :CLIDES ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  ' + strCampo + ' = :CLIORI ';

      If Not fEmptyStr(strEmpresas) Then
        strSQL := strSQL + ' AND MSA_CODEMP NOT IN('+strEmpresas+') ';

      qryTmp.Close;
      qryTmp.SQL.Clear;
      qryTmp.SQL.Add(strSQL);
      qryTmp.ParamByName('CLIDES').AsString := strCliDes;
      qryTmp.ParamByName('CLIORI').AsString := strCliOri;
      qryTmp.ExecSQL;

      Result := qryTmp.RowsAffected;
    Finally
      FreeAndNil(qryTmp);
    End;

  End;

begin
  Try

    Result := 0;

    qryGenTmp := fCriaQuery(Self);

    If intOpcao = 2 Then
      strNomArq := 'DEL_' + strNomArq;

    If Not fTabelaExiste(strNomArq) Then
      Exit;

    if Not fCampoExiste(strNomArq, strCampo) then
      Exit;

    If SameText(strNomArq, 'ENTCLI') Or
       SameText(strNomArq, 'DEL_ENTCLI') Then
    Begin
      With qryGenTmp Do
      Begin
        intSeqInd := fGetUltimoSeqIndEndEntrega(secSeqInd);
        intSeqVis := fGetUltimoSeqIndEndEntrega(secSeqVis);

        pGetEnderecosEntregaCliOri;

        If Not IsEmpty Then
        Begin
          First;

          While Not Eof Do
          Begin
            Result := Result + fInsertEnderecoEntregaCliDes;

            Next;
          End;
        End;

        Exit;
      End;

    End;

    If SameText(strNomArq, 'CLIVEI') Or
       SameText(strNomArq, 'DEL_CLIVEI') Then
    Begin
      pTransVeiCliOri;

      Exit;
    End;

    If SameText(strNomArq, 'CLIDIV') Or
       SameText(strNomArq, 'DEL_CLIDIV') Then
    Begin
      pTransfCliDiv;

      Exit;
    End;

    If SameText(strNomArq, 'EXEMSA') Or
       SameText(strNomArq, 'DEL_EXEMSA') Then
    Begin
      Result := fTransfereEmpresaArmazem;

      Exit;
    End;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  ' + strNomArq + ' ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  ' + strCampo + ' = :CLIDES ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ' + strCampo + ' = :CLIORI ';

    If (strNomArq = 'LOGNFE') Then
      strSQL := strSQL + ' AND NFE_TIP_FC = "C" '
    Else
    If (strNomArq = 'CADFIS') Then
      strSQL := strSQL + ' AND FIS_TIP_FC = "C" '
    Else
    If (strNomArq = 'ADEDET') Then
      strSQL := strSQL + ' AND DET_TIP_FC = "C" '
    Else
    If (strNomArq = 'DOCDTA') Then
      strSQL := strSQL + ' AND DOC_TIP_FC = "C" '
    Else
    If (strNomArq = 'CFGSIS') Then
    Begin
      strCFG := '';

      If Assigned(ProcRetCfgRelacionadaArquivo) then
        strCFG := ProcRetCfgRelacionadaArquivo('CADCLI');

      if not fEmptyStr(strCFG) then
        strSQL := strSQL + ' AND SIS_CODCFG IN (' + strCFG + ')'
      Else
      Begin
        Result := 0;
        Exit;
      End;
    End;


    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CLIDES').AsString := strCliDes;
      ParamByName('CLIORI').AsString := strCliOri;
      ExecSQL;
      Result := RowsAffected;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

procedure TfrmTransfCodCliente.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If (fVerificaCampos) Then
  Begin
     If (Sender <> objExcelTrans) And
       (fMensagem('', 'Confirma transferência?', ['&Sim', '&Não'], 2) <> 1) Then
       Exit;

    btnConfirmaDados.Enabled := False;
    If (fTransfereCodCliente) Then
    Begin
      objExcelTrans.pAddNotificacao('Código de cliente transferido corretamente!');

      lsvArqAlterados.Clear;
      btnConfirmaDados.Enabled := True;

      edtCliOri.Clear;
      edtDesCliOri.Clear;
      edtCliDes.Clear;
      edtDesCliDes.Clear;

      pSetFocus(edtCliOri);
    End;

  End;

end;

function TfrmTransfCodCliente.fChecarTabelas(pgbProgresso: TCxProgressBar): Boolean;
Begin
  frmGravando.lblGravando.Caption := 'Validando Chave Estrangeira do Banco de Dados. Aguarde...';
  Application.ProcessMessages;

  pPreencheArray(pgbProgresso);
  pCriaClientCliente;
  Result := True;
End;

procedure TfrmTransfCodCliente.FormShow(Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fChecarTabelas;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodCliente.FormShow]');
    End;
  End;

  pFreeAndNil(frmGravando);

  Screen.Cursor := crDefault;
  pMostraDivergencia;

end;

procedure TfrmTransfCodCliente.pGravaLogChq(strTabela, strCliOri, strCliDes: String);
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    repCadChq  : TCadChqRepository;
begin

  strSQL := '';
  strSQL := strSQL + ' SELECT *               ';
  strSQL := strSQL + ' FROM ' + strTabela      ;
  strSQL := strSQL + ' WHERE                  ';
  strSQL := strSQL + '   CHQ_CODCLI = :CODCLI ';

  qryConsulta := fCriaQuery;

  With qryConsulta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCliOri;
    Open;
    First;

    repCadChq := TCadChqRepository.Create;

    While Not Eof Do
    Begin
      repCadChq.pGravaLog(FieldByName('CHQ_CODBCO').AsString, FieldByName('CHQ_NUMAGE').AsString,
                          FieldByName('CHQ_CONCOR').AsString, FieldByName('CHQ_NUMCHQ').AsString,
                          'TRANSFERIU DO CLIENTE ' + strCliOri + ' PARA ' + strCliDes);
      Next;
    End;

    FreeAndNil(repCadChq);
  End;

  FreeAndNil(qryConsulta);
end;

procedure TfrmTransfCodCliente.pCriaClientCliente;
begin

  If Not Assigned(cdsCliente) Then
  Begin
    cdsCliente := TZClient.Create(Self);

    With cdsCliente, qryQuery, SQL Do
    Begin
      Add('SELECT DISTINCT');
      Add('  table_name AS TABELA,');
      Add('  column_name AS CAMPO,');
      Add('  "S" AS EXISTE');
      Add('  FROM information_schema.KEY_COLUMN_USAGE');
      Add('  LEFT JOIN TCOARR ON TCA_ARQREL = table_name AND TCA_CAMREL = column_name');
      Add('  WHERE');
      Add('      referenced_table_name = "CADCLI"');
      Add('  AND referenced_column_name = "CLI_CODCLI"');
      Add('  AND TCA_ARQREL IS NULL');
      Add('  AND NOT LOCATE(table_name, "CADFIC_CADRCXY_CLI_INFCRE")');

      If Assigned(frmModulo) Then
        Add('  AND CONSTRAINT_SCHEMA = ' + QuotedStr(frmModulo.GetCurrentConnection.database));

      fAbreClient(True, 'pCriaClientProduto');
    End;
  End;

end;

procedure TfrmTransfCodCliente.pMostraDivergencia;
begin

  With cdsCliente Do
  Begin

    If Not IsEmpty Then
    Begin
      pCriaForm;
    End
    Else
      blnDivergencia := False;

  End;

end;

procedure TfrmTransfCodCliente.pCriaForm;
  Var
    Form: TForm;
    Memo: TMemo;
begin

  Try

    pCriarFormularios(TForm, Form);

    Form.BorderStyle := bsDialog;
	  Form.Position    := poScreenCenter;
	  Form.Width       := 400;
	  Form.Height      := 400;
    Form.Font.Name   := 'Arial';
    Form.Font.Size   := 10;
    Form.Color       := $00FFE4D5;

	  With TLabel.Create(form) do
    Begin
		  Parent     := Form;
		  Caption    := 'Tabela(s) que não existe(m) na lista :';
		  Left       := 10;
		  Top        := 10;
      Font.Style := [fsBold];
	  End;

	  With TBitBtnLocked.Create(form) Do
    Begin
		  Parent  := form;
      Width   := 100;
		  Height  := 23;
		  Left    := 280;
		  Top     := 340;
		  Kind    := bkClose;
      Caption := '&Sair';
	  End;

		Memo := TMemo.Create(form);

	  With Memo Do
    Begin
		  Parent     := form;
		  Left       := 10;
		  Top        := 35;
      Color      := clInfoBk;
		  Width      := form.ClientWidth - 22;
      Height     := 300;
      ScrollBars := ssBoth;

      With cdsCliente Do
      Begin
        First;
        While Not Eof Do
        Begin
          If (Trim(FieldByName('TABELA').AsString) <> 'CADRCXY') And
             (Trim(FieldByName('TABELA').AsString) <> 'MOVOCO')  Then
            Lines.Add(FieldByName('TABELA').AsString + ' - ' + FieldByName('CAMPO').AsString);
          Next;
        End;
      End;

      ReadOnly := True;
	  End;

    Form.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTransfCodCliente.pCriaForm]');
    End;
  End;

  pFreeAndNil(Form);

end;


procedure TfrmTransfCodCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(cdsCliente);
  
end;

procedure TfrmTransfCodCliente.FormPaint(Sender: TObject);
begin
  inherited;

  If blnDivergencia Then
    btnSair.Click;
    
end;

procedure TfrmTransfCodCliente.edtCliOriExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtCliOri.Text) Then
  Begin
    If (fMensagem('', 'Exibir Conta Corrente do Cliente?', ['&Sim', '&Não'], 2) = 1) Then
      TfrmMostraDebCtrChq2.pMostraContaCorrente(edtCliOri.Text, 'A');
  End;

end;

procedure TfrmTransfCodCliente.pPreencheArray(pgbProgresso: TCxProgressBar);
  Var
    intPosicao: Integer;
    qryTcoArr : TUniQuery;
begin
  Try
    qryTcoArr := fCriaQuery();
    With qryTcoArr, SQL Do
    Begin
      Add(' SELECT                ');
      Add(' TCA_ARQREL,           ');
      Add(' TCA_CAMREL,           ');
      Add(' TCA_DESCRI            ');
      Add(' FROM TCOARR           ');
      Add(' WHERE                 ');
      Add(' TCA_ARQUIV = "CADCLI" ');
      Add(' AND NOT LOCATE(TCA_ARQREL, "CADFIC_CADRCXY_CLI_INFCRE") ');

      Open;

      intPosicao := 0;
      While Not Eof Do
      Begin
        pRegistraProgresso(pgbProgresso, MSG_VALID_FOREIGN_KEY, RecNo, RecordCount);

        If Not fIgnorarCampo(FieldByName('TCA_ARQREL').AsString,
                             FieldByName('TCA_CAMREL').AsString) Then
        Begin
          SetLength(arrCamposCliente, succ(intPosicao));

          arrCamposCliente[intPosicao].strNomArq := FieldByName('TCA_ARQREL').AsString;
          arrCamposCliente[intPosicao].strDesCam := FieldByName('TCA_DESCRI').AsString;
          arrCamposCliente[intPosicao].strCamCod := FieldByName('TCA_CAMREL').AsString;
          
          inc(intPosicao);
        End;          

        Next;
      End;

    End;

  Finally
    FreeAndNil(qryTcoArr);
  End;

end;

procedure TfrmTransfCodCliente.pRegistraProgresso(pbProgress: TCxProgressBar; strMsg: String; intPos, intMax: Integer);
begin
  If Assigned(pbProgress) Then
  Begin
    pbProgress.Properties.Max := intMax;
    pbProgress.Position := intPos;

    If GetParentForm(pbProgress).FindComponent('lblGravando') <> nil Then
    Begin
      TLabel(GetParentForm(pbProgress).FindComponent('lblGravando')).Caption := strMsg + ' ' + intToStr(intPos) + '/' + intToStr(intMax);
    End;

    Application.ProcessMessages;
  End;
end;

end.



