unit untChqHistorico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
   Uni, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, DBCtrls, DBEditFocus,
  untFuncoes, AppEvnts;

type
  TfrmChqHistorico = class(TfrmPaiOrdena)
    edtCodBco: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    edtNumAge: TEditFocus;
    Label3: TLabel;
    edtConCor: TEditFocus;
    Label4: TLabel;
    edtNumChq: TEditFocus;
    Label27: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtNomBan: TEditFocus;
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label6: TLabel;
    mskDtaFin: TMaskEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure edtCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure cdsConsultaAfterEdit(DataSet: TDataSet);
    procedure cdsConsultaBeforeClose(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodEmpEnter(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMudaOrdemClick(Sender: TObject);
  private
    { Private declarations }
    qryConEmp,
    qryConBco: TUniQuery;

    Function fAtualizaCadChq(DataSet: TDataSet): Boolean;

    procedure pCarregaBanco;
    procedure pCarregaEmpresa;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
    function fGetActiveControl: TWinControl; Override;
  end;

var
  frmChqHistorico: TfrmChqHistorico;

implementation

uses untModuloCadBco, untPesqAux, untModuloCadEmp;

{$R *.dfm}

function TfrmChqHistorico.fGetActiveControl: TWinControl;
Begin
  Result := edtCodEmp;
End;

procedure TfrmChqHistorico.pCarregaBanco;
begin
  pPesquisaCadBco(frmModuloCadBco.qryCadBco, qryConBco, edtCodBco.Text);
  edtNomBan.Text := qryConBco.FieldByName('BCO_NOMBCO').AsString;
end;

procedure TfrmChqHistorico.pCarregaEmpresa;
begin
  pPesquisaCadEmp(frmModuloCadEmp.qryCadEmp, qryConEmp, edtCodEmp.Text);
  edtNomEmp.Text := qryConEmp.FieldByName('EMP_NOMEMP').AsString;
end;

function TfrmChqHistorico.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CÓIDIGO DO BANCO             *}
    {**************************************LA*}
    If (Sender = edtCodBco) Then
    Begin

      If Not fEmptyStr(edtCodBco.Text) Then
      Begin
        pCarregaBanco;
        If qryConBco.FieldByName('BCO_CODBCO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Banco não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End Else
        edtNomBan.Clear;

    End

    {*****************************************}
    {* VALIDA A AGENCIA                      *}
    {**************************************LA*}
    Else If (Sender = edtNumAge) Then
    Begin

    End

    {*****************************************}
    {* VALIDA  A CONTA CORRENTE              *}
    {**************************************LA*}
    Else If (Sender = edtConCor) Then
    Begin


    End

    {*****************************************}
    {* VALIDA O NÚMERO DO CHEQUE             *}
    {**************************************LA*}
    Else If (Sender = edtNumChq) Then
    Begin

    End

    {*****************************************}
    {* VALIDA O CÓDIGO DA EMPRESA            *}
    {**************************************LA*}
    Else If (Sender = edtCodEmp) Then
    Begin
      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
        pCarregaEmpresa;
        If qryConEmp.FieldByName('EMP_CODEMP').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
          Result := False;
        End
      End Else
        edtNomEmp.Clear;
    End

    Else If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Enabled := False;
        mskDtaFin.Clear;
        fAbreConsulta(TRUE);
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
      End;
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Digite a data Final!', ['&O k']);
        Result := False;
      End

      Else If Not (fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
        Result := False;
      End

      Else fAbreConsulta(TRUE);

    End

  End;

  If Not Result Then
    Sender.SetFocus;
end;

procedure TfrmChqHistorico.FormCreate(Sender: TObject);
begin
  inherited;

  qryConBco := frmModuloCadBco.qryCadBco;
  qryConEmp := frmModuloCadEmp.qryCadEmp;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftDateTime;

  blnTemSelecao := FALSE;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmp.Text := VS_strCodEmp;
  pCarregaEmpresa;

end;

function TfrmChqHistorico.fGetSql(blnLike: Boolean): String;

  Function fSelect(strNomeTabela: String): String;
    Var
      strSQL: String;
  Begin
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CHQ_DTACAD, ';
    strSQL := strSQL + '  CHQ_DTAVEN, ';
    strSQL := strSQL + '  CHQ_CODBCO, ';
    strSQL := strSQL + '  BCO_NOMBCO, ';
    strSQL := strSQL + '  CHQ_NUMAGE, ';
    strSQL := strSQL + '  CHQ_CONCOR, ';
    strSQL := strSQL + '  CHQ_NUMCHQ, ';
    strSQL := strSQL + '  CHQ_HIST01, ';
    strSQL := strSQL + '  CHQ_HIST02, ';
    strSQL := strSQL + '  CHQ_CODCLI, ';
    strSQL := strSQL + '  CLI_NOMCLI, ';
    strSQL := strSQL + '  CHQ_NOMEMI, ';
    strSQL := strSQL + '  CHQ_VALCHQ, ';
    strSQL := strSQL + '  CHQ_C_G_C_, ';
    strSQL := strSQL + '  CHQ_CODEMP, ';
    strSQL := strSQL + '  Q.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + QuotedStr(strNomeTabela) + ' AS NOMETABELA ';
    strSQL := strSQL + 'FROM                          ';
    strSQL := strSQL + strNomeTabela + ' AS Q         ';
    strSQL := strSQL + 'INNER JOIN CADCLI AS C ON     ';
    strSQL := strSQL + '  Q.CHQ_CODCLI = C.CLI_CODCLI ';
    strSQL := strSQL + 'INNER JOIN CADBCO AS B ON     ';
    strSQL := strSQL + '  Q.CHQ_CODBCO = B.BCO_CODBCO ';
    strSQL := strSQL + 'WHERE TRUE                    ';

    If Not fEmptyStr(edtCodBco.Text) Then
      strSQL := strSQL + '  AND CHQ_CODBCO = :CODBCO  ';

    If Not fEmptyStr(edtNumAge.Text) Then
      strSQL := strSQL + '  AND CHQ_NUMAGE = :NUMAGE  ';

    If Not fEmptyStr(edtConCor.Text) Then
      strSQL := strSQL + '  AND CHQ_CONCOR = :CONCOR  ';

    If Not fEmptyStr(edtNumChq.Text) Then
      strSQL := strSQL + '  AND CHQ_NUMCHQ = :NUMCHQ  ';

    If Not fEmptyStr(edtCodEmp.Text) Then
      strSQL := strSQL + '  AND CHQ_CODEMP = :CODEMP  ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      strSQL := strSQL + '  AND Q.CHQ_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

    Result := strSQL;
  End;

Begin
  Result := fSelect('CADCHQ') + fFiltraSQL(blnLike) + 
            ' UNION ALL ' + fSelect('CADCHQX');
End;

function TfrmChqHistorico.fSetParametros: Boolean;
Begin
  With qryConsulta Do
  Try

    If Not fEmptyStr(edtCodBco.Text) Then
      ParamByName('CODBCO').AsString := edtCodBco.Text;

    If Not fEmptyStr(edtNumAge.Text) Then
      ParamByName('NUMAGE').AsString := edtNumAge.Text;

    If Not fEmptyStr(edtConCor.Text) Then
      ParamByName('CONCOR').AsString := edtConCor.Text;

    If Not fEmptyStr(edtNumChq.Text) Then
      ParamByName('NUMCHQ').AsString := edtNumChq.Text;

    If Not fEmptyStr(edtCodEmp.Text) Then
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

    Result := TRUE;
  Except
    Result := FALSE;
  End;
End;


procedure TfrmChqHistorico.edtCodBcoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndiceBco, stlDesIndBco, stlCamposBco: TStringList;
begin
  inherited;
  stlIndiceBco := TStringList.Create;
  stlDesIndBco := TStringList.Create;
  stlCamposBco := TStringList.Create;

  If fEntraCons(Key) Then
  Begin
    Key := #0;

    stlCamposBco.Add('BCO_CODBCO');
    stlCamposBco.Add('BCO_NOMBCO');
    stlCamposBco.Add('AUTOINCREM');

    stlIndiceBco.Add('BCO_NOMBCO');
    stlIndiceBco.Add('BCO_CODBCO');
    stlDesIndBco.Add('Nome');
    stlDesIndBco.Add('Código');

    If pConsultaRapida(Self, qryConBco, 'CADBCO', stlIndiceBco, stlDesIndBco, stlCamposBco) Then
    Begin
      edtCodBco.Text := qryConBco.FieldByName('BCO_CODBCO').AsString;
      Self.SelectNext(ActiveControl, True, True);
    End;
    pCarregaBanco;
  End;

  FreeAndNil(stlCamposBco);
  FreeAndNil(stlIndiceBco);
  FreeAndNil(stlDesIndBco);

end;

procedure TfrmChqHistorico.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamposEmp: TStringList;
    stlCamIndEmp: TStringList;
    stlDesIndEmp: TStringList;
begin
  inherited;

  stlCamposEmp := TStringList.Create;
  stlCamIndEmp := TStringList.Create;
  stlDesIndEmp := TStringList.Create;

  If fEntraCons(Key) Then
  Begin
    Key := #0;
    stlCamposEmp.Add('EMP_NOMEMP');
    stlCamposEmp.Add('EMP_CODEMP');
    stlCamposEmp.Add('AUTOINCREM');

    stlCamIndEmp.Add('EMP_NOMEMP');
    stlCamIndEmp.Add('EMP_CODEMP');

    stlDesIndEmp.Add('Empresa');
    stlDesIndEmp.Add('Código');

    If pConsultaRapida(Self, qryConEmp, 'CADEMP', stlCamIndEmp, stlDesIndEmp, stlCamposEmp) Then
    Begin
      edtCodEmp.Text := qryConEmp.FieldByName('EMP_CODEMP').AsString;
      Self.SelectNext(ActiveControl, True, True);
    End;
    pCarregaEmpresa;
  End;

  FreeAndNil(stlCamposEmp);
  FreeAndNil(stlCamIndEmp);
  FreeAndNil(stlDesIndEmp);

end;

Function TfrmChqHistorico.fAtualizaCadChq(DataSet: TDataSet): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin

  Result := False;

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + DataSet.FieldByName('NOMETABELA').AsString;
    strSQL := strSQL + ' SET    ';
    strSQL := strSQL + '   CHQ_HIST01 = :HIST01, ';
    strSQL := strSQL + '   CHQ_HIST02 = :HIST02  ';
    strSQL := strSQL + ' WHERE  ';
    strSQL := strSQL + '   AUTOINCREM = :AUTOIN  ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('HIST01').AsString := DataSet.FieldByName('CHQ_HIST01').AsString;
      ParamByName('HIST02').AsString := DataSet.FieldByName('CHQ_HIST02').AsString;
      ParamByName('AUTOIN').AsString := DataSet.FieldByName('AUTOINCREM').AsString;

      ExecSQL;

      Close;
    End;

    FreeAndNil(qryGen);

  Except
    On E: Exception Do
    Begin
      fMensagem('','Erro: ' + E.Message,['&OK']);
      FreeAndNil(qryGen);
    End;
  End;

End;

procedure TfrmChqHistorico.cdsConsultaAfterPost(DataSet: TDataSet);
begin
  inherited;

  fAtualizaCadChq(DataSet);
end;

procedure TfrmChqHistorico.cdsConsultaAfterEdit(DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
  Begin
    If fEmptyStr(FieldByName('CHQ_HIST01').AsString) Then
      FieldByName('CHQ_HIST01').Clear;
    If fEmptyStr(FieldByName('CHQ_HIST02').AsString) Then
      FieldByName('CHQ_HIST02').Clear;
  End;

end;

procedure TfrmChqHistorico.cdsConsultaBeforeClose(DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
    If State = dsEdit Then
      Post;

end;

procedure TfrmChqHistorico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If cdsConsulta.Active Then
    cdsConsulta.Close;

end;

procedure TfrmChqHistorico.edtCodEmpEnter(Sender: TObject);
begin
  inherited;

  If cdsConsulta.Active Then
    cdsConsulta.Close;

end;

procedure TfrmChqHistorico.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of

    VK_RETURN: If cdsConsulta.Active And
                  (Not SameText(dbgConsulta.SelectedField.FieldName,'CHQ_HIST01')) And
                  (Not SameText(dbgConsulta.SelectedField.FieldName,'CHQ_HIST02')) Then
                 cdsConsulta.FieldByName('CHQ_HIST01').FocusControl;

    VK_F3    : If cdsConsulta.Active Then
                 cdsConsulta.FieldByName(lflLastField.strNomCam).FocusControl;
  End;

end;

procedure TfrmChqHistorico.btnMudaOrdemClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.Active Then
    cdsConsulta.FieldByName(lflLastField.strNomCam).FocusControl;
end;

end.
