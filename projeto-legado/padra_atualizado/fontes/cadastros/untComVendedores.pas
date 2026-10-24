unit untComVendedores;

interface

uses
  Windows, Classes, Controls, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids,
  DBGridCitel, DBGrids, DB, Uni, EditFocus, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, StrUtils;

type
  TfrmComVendedores = class(TfrmPai)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    lblCodOpe: TLabel;
    Label3: TLabel;
    lblNomOpe: TLabel;
    dbgComVen: TDBGridCitel;
    lblCodigo: TLabel;
    lblDescri: TLabel;
    lblInicial: TLabel;
    lblFinal: TLabel;
    lblComis: TLabel;
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    edtInicial: TEditFocus;
    edtFinal: TEditFocus;
    edtComis: TEditFocus;
    Label2: TLabel;
    dtsComOpe: TDataSource;
    btnIncluir: TBitBtnLocked;
    lblAviso: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure pAtualizaGrid;
    procedure dbgComVenKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pLimpaForm;
    procedure edtFinalExit(Sender: TObject);
    procedure edtInicialExit(Sender: TObject);
    procedure edtComisExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    qryAltera, qryComOpe: TUniQuery;
  public
    { Public declarations }
    strStatus: String;
  end;

implementation

uses SysUtils, Forms, untFuncoesSimples;

{$R *.dfm}

procedure TfrmComVendedores.pLimpaForm;
begin
  lblCodigo.Enabled  := False;
  edtCodigo.Clear;

  lblDescri.Enabled  := False;
  edtDescri.Enabled  := False;
  edtDescri.Clear;
  lblInicial.Enabled := False;
  edtInicial.Enabled := False;
  edtInicial.Clear;
  lblFinal.Enabled   := False;
  edtFinal.Enabled   := False;
  edtFinal.Clear;
  lblComis.Enabled   := False;
  edtComis.Enabled   := False;
  edtComis.Clear;

  btnIncluir.Enabled := False;

  strStatus := '';

  pSetFocus(dbgComVen);
end;

procedure TfrmComVendedores.pAtualizaGrid;
begin
  Screen.Cursor := crSQLWait;

  With qryComOpe Do
  Begin
    DisableControls;

    Close;
    SQL.Clear;
    SQL.Add(' SELECT  ');
    SQL.Add('     *   ');
    SQL.Add(' FROM COMOPE                    ');
    SQL.Add(' WHERE COM_CODOPE = :CODOPE     ');

    If (fCfgSis('OPCCOM', varString) = 'MVI') Then
    Begin
      SQL.Add('  AND COM_CODEMP =:CODEMP');
      ParamByName('CODEMP').AsString := VS_strCodEmp;
    End;


    ParamByName('CODOPE').AsString := lblCodOpe.Caption;

    Open;
    (FieldByName('COM_PERINI') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('COM_PERFIN') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('COM_PERCOM') As TFloatField).DisplayFormat := '#,##0.00';

    EnableControls;
  End;

  Screen.Cursor := crDefault;
end;

procedure TfrmComVendedores.FormCreate(Sender: TObject);
begin
  inherited;
  qryComOpe := fCriaQuery(Self);
  dtsComOpe.DataSet := qryComOpe;
end;

procedure TfrmComVendedores.FormShow(Sender: TObject);
begin
  inherited;

  pAtualizaGrid;
  pLimpaForm;

  If (fCfgSis('OPCCOM', varString) = 'MVI') Then
  Begin
    lblAviso.Visible := True;
    lblAviso.Caption := AnsiReplaceStr(AnsiReplaceStr(lblAviso.Caption, '<XXX>', VS_strCodEmp), '<NOMEDAEMPRESA>', fRetNomeEmpresa());
  End;
end;

procedure TfrmComVendedores.btnIncluirClick(Sender: TObject);
var
  blnConfirma: Boolean;
begin
  inherited;

  Screen.Cursor := crSQLWait;

  qryAltera := fCriaQuery(Self);

  If fVerificaCampos Then
  Begin
    If (strStatus = 'N') Then
    Begin
      {***************************************}
      {* VERIFICA A CONSISTENCIA DOS VALORES *}
      {**30/11/2007************************ER*}
      blnConfirma := True;

      If qryComOpe.RecordCount > 0 Then
      Begin
        qryComOpe.Last;

        If fStrToFloat(edtInicial.Text) <= qryComOpe.FieldByName('COM_PERFIN').AsFloat Then
        Begin
          fMensagem('Atenção', 'O percentual inicial deve ser maior do que o último percentual final', ['&OK']);
          pSetFocus(edtInicial);
          blnConfirma := False;
        End;
      End;

      If blnConfirma Then
      Begin
        fStartTransaction;
        Try
          With qryAltera Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(' INSERT INTO ');
            SQL.Add('   COMOPE ');
            SQL.Add('     (COM_CODCOM, COM_CODOPE, ');
            SQL.Add('      COM_CODEMP, COM_DESCOM, ');
            SQL.Add('      COM_PERINI, COM_PERFIN, ');
            SQL.Add('      COM_PERCOM, AUTOINCREM) ');
            SQL.Add('   VALUES ');
            SQL.Add('     (:CODCOM, :CODOPE,       ');
            SQL.Add('      :CODEMP, :DESCOM,       ');
            SQL.Add('      :PERINI, :PERFIN,       ');
            SQL.Add('      :PERCOM, :AUTOIN)       ');
            ParamByName('CODCOM').AsString := fAtualizaProCod('COMOPE', 'COM_CODCOM');
            ParamByName('CODOPE').AsString := lblCodOpe.Caption;
            ParamByName('CODEMP').AsString := VS_strCodEmp;
            ParamByName('DESCOM').AsString := edtDescri.Text;
            ParamByName('PERINI').AsFloat  := fStrToFloat(edtInicial.Text);
            ParamByName('PERFIN').AsFloat  := fStrToFloat(edtFinal.Text);
            ParamByName('PERCOM').AsFloat  := fStrToFloat(edtComis.Text);
            ParamByName('AUTOIN').AsString := fRetAutoIncrem('COMOPE', VS_strCodEmp);
            ExecSQL;
          End;

          fCommit;

          pAtualizaGrid;
          pLimpaForm;

          Screen.Cursor := crDefault;
        Except
          On E: Exception Do
          Begin
            fRollBack;
            Screen.Cursor := crDefault;
						pMensagensErro(E.Message,'[TfrmComVendedores.btnIncluirClick]');
          End;
        End;
      End;
    End
    Else If (strStatus = 'A') Then
    Begin
      {***************************************}
      {* VERIFICA A CONSISTENCIA DOS VALORES *}
      {***30/11/2007***********************ER*}
      blnConfirma := True;

      If qryComOpe.RecNo > 1 Then
      Begin
        qryComOpe.Prior;

        If fStrToFloat(edtInicial.Text) <= qryComOpe.FieldByName('COM_PERFIN').AsFloat Then
        Begin
          fMensagem('Atenção', 'O percentual inicial deve ser maior do que o último percentual final', ['&OK']);
          pSetFocus(edtInicial);
          blnConfirma := False;
        End;

        qryComOpe.Next;
      End;

      If blnConfirma Then
      Begin
        fStartTransaction;

        Try
          With qryAltera Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(' UPDATE ');
            SQL.Add('   COMOPE SET ');
            SQL.Add('       COM_DESCOM = :DESCOM,   ');
            SQL.Add('       COM_PERINI = :PERINI,   ');
            SQL.Add('       COM_PERFIN = :PERFIN,   ');
            SQL.Add('       COM_PERCOM = :PERCOM    ');
            SQL.Add('   WHERE COM_CODCOM = :CODCOM  ');
            SQL.Add('   AND   COM_CODOPE = :CODOPE  ');
            SQL.Add('   AND   COM_CODEMP = :CODEMP  ');
            ParamByName('CODCOM').AsString := qryComOpe.FieldByName('COM_CODCOM').AsString;
            ParamByName('CODOPE').AsString := qryComOpe.FieldByName('COM_CODOPE').AsString;
            ParamByName('CODEMP').AsString := qryComOpe.FieldByName('COM_CODEMP').AsString;
            ParamByName('DESCOM').AsString := edtDescri.Text;
            ParamByName('PERINI').AsFloat  := fStrToFloat(edtInicial.Text);
            ParamByName('PERFIN').AsFloat  := fStrToFloat(edtFinal.Text);
            ParamByName('PERCOM').AsFloat  := fStrToFloat(edtComis.Text);
            ExecSQL;
          End;

          fCommit;

          pAtualizaGrid;
          pLimpaForm;

          Screen.Cursor := crDefault;
        Except
          On E: Exception Do
          Begin
            fRollBack;

            Screen.Cursor := crDefault;
						pMensagensErro(E.Message,'[TfrmComVendedores.btnIncluirClick]');
          End;
        End;
      End;
    End;
  End;

  Screen.Cursor := crDefault;
end;

procedure TfrmComVendedores.dbgComVenKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_DELETE) Then
  Begin
    If fMensagem('Confirmação', 'Confirma exclusão de comissão para este operador?',['&Sim','&Não'], 2) = 1 Then
    Begin
      qryAltera := fCriaQuery(Self);

      fStartTransaction;

      Try
        With qryAltera Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(' DELETE FROM ');
          SQL.Add('    COMOPE ');
          SQL.Add(' WHERE COM_CODCOM = :CODCOM AND ');
          SQL.Add('       COM_CODOPE = :CODOPE     ');

          If (fCfgSis('OPCCOM', varString) = 'MVI') Then
          Begin
            SQL.Add('  AND COM_CODEMP =:CODEMP');
            ParamByName('CODEMP').AsString := qryComOpe.FieldByName('COM_CODEMP').AsString;
          End;

          ParamByName('CODCOM').AsString := qryComOpe.FieldByName('COM_CODCOM').AsString;
          ParamByName('CODOPE').AsString := qryComOpe.FieldByName('COM_CODOPE').AsString;
          ExecSQL;
        End;

        fCommit;

        pAtualizaGrid;

        pSetFocus(dbgComVen);
      Except
        On e:Exception Do
        Begin
          fRollBack;
					pMensagensErro(E.Message,'[TfrmComVendedores.dbgComVenKeyDown]');
          pSetFocus(dbgComVen);
        End;
      End;
    End;
  End;

  If (Key = VK_RETURN) Then
  Begin
    If (qryComOpe.RecordCount > 0) Then
    Begin
      lblCodigo.Enabled  := True;
      edtCodigo.Text     := qryComOpe.FieldByName('COM_CODCOM').AsString;

      lblDescri.Enabled  := True;
      edtDescri.Enabled  := True;
      edtDescri.Text     := qryComOpe.FieldByName('COM_DESCOM').AsString;
      lblInicial.Enabled := True;
      edtInicial.Enabled := True;
      edtInicial.Text    := FloattoStrF(qryComOpe.FieldByName('COM_PERINI').AsFloat, ffFixed, 10, 2);
      lblFinal.Enabled   := True;
      edtFinal.Enabled   := True;
      edtFinal.Text      := FloatToStrF(qryComOpe.FieldByName('COM_PERFIN').AsFloat, ffFixed, 10, 2);
      lblComis.Enabled   := True;
      edtComis.Enabled   := True;
      edtComis.Text      := FloatToStrF(qryComOpe.FieldByName('COM_PERCOM').AsFloat, ffFixed, 10, 2);

      btnIncluir.Enabled := True;

      pSetFocus(edtDescri);

      strStatus := 'A';
    End;
  End;

  If (Key = VK_INSERT) Then
  Begin
    lblCodigo.Enabled  := True;
    edtCodigo.Clear;

    lblDescri.Enabled  := True;
    edtDescri.Enabled  := True;
    edtDescri.Clear;
    lblInicial.Enabled := True;
    edtInicial.Enabled := True;
    edtInicial.Clear ;
    lblFinal.Enabled   := True;
    edtFinal.Enabled   := True;
    edtFinal.Clear;
    lblComis.Enabled   := True;
    edtComis.Enabled   := True;
    edtComis.Clear;

    btnIncluir.Enabled := True;

    pSetFocus(edtDescri);

    strStatus := 'N';
  End;

  If (Key = VK_ESCAPE) Then
    btnSairClick(Sender);
end;

procedure TfrmComVendedores.edtFinalExit(Sender: TObject);
begin
  inherited;
  Try
    edtFinal.Text := FloatToStrF(fStrToFloat(edtFinal.Text), ffFixed, 10, 2);
  Except
  End;

  If edtFinal.Text <> '' Then
    If fStrToFloat(edtFinal.Text) <= fStrToFloat(edtInicial.Text) Then
    Begin
      fMensagem('Aviso', 'O percentual final deve ser maior do que o inicial', ['&OK']);
      pSetFocus(edtFinal);
    End;

end;

procedure TfrmComVendedores.edtInicialExit(Sender: TObject);
begin
  inherited;
  Try
    edtInicial.Text := FloatToStrF(fStrToFloat(edtInicial.Text), ffFixed, 10, 2);
  Except
  End;

end;

procedure TfrmComVendedores.edtComisExit(Sender: TObject);
begin
  inherited;
  Try
    edtComis.Text := FloatToStrF(fStrToFloat(edtComis.Text), ffFixed, 10, 2);
  Except
  End;

end;

end.

