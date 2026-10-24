unit untBaixaVolumes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, Uni, untHelperCitel,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, cxProgressBar,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel, cxDBLabel, EditFocus,
  Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.DBCtrls, untZClient;

type
  TfrmBaixaVolumes = class(TfrmPai)
    pnlTop: TPanel;
    edtAcesso: TEditFocus;
    Label1: TLabel;
    pnlDadosNota: TPanel;
    Label2: TLabel;
    dbtNomCli: TDBText;
    Bevel2: TBevel;
    Bevel1: TBevel;
    Label3: TLabel;
    dbtNomTra: TDBText;
    Bevel3: TBevel;
    Label4: TLabel;
    dbtVolume: TDBText;
    Bevel4: TBevel;
    dbgDados: TDBGridCitel;
    pnlColeta: TPanel;
    edtNumObj: TEditFocus;
    Label5: TLabel;
    btnConfirma: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
  private
    cdsVolumes : TZClient;
    intQtdCon  : Integer;
    procedure pGetTextNumObj(Sender: TField; var Text: String; Display: Boolean);
    procedure pIniciaConferencia;
    function fConfirma(cxProgress: TcxProgressBar): Boolean;
  public
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean; override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untGravando;

procedure TfrmBaixaVolumes.btnConfirmaClick(Sender: TObject);
  Var
    frmGravando : TfrmGravando;
begin
  inherited;
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fConfirma;
    frmGravando.ShowModal;
  Finally
    FreeAndNIl(frmGravando);
  End;
end;

function TfrmBaixaVolumes.fConfirma(cxProgress : TcxProgressBar):Boolean;
  Var
    qryUpdate : TUniQuery;
Begin
  Result := True;
  Try
    qryUpdate := fCriaQuery(Self);
    With qryUpdate, SQL Do
    Begin
      Close;
      Clear;
      Add(' UPDATE PLPDOC SET PLD_OPECON = :CODOPE, ');
      Add('                   PLD_DTACON = :DTACON  ');
      Add(' WHERE AUTOINCREM = :AUTINC              ');

      ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;
      ParamByName('DTACON').AsDateTime := fNow;

    End;

    Try
      With cdsVolumes Do
      Begin

        First;
        cxProgress.pSetMax(RecordCount);
        cxProgress.Position := 0;

        While Not Eof Do
        Begin
          qryUpdate.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
          qryUpdate.ExecSQL;

          cxProgress.pStepBy;
          Next;
        End;

      End;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmBaixaVolumes.fConfirma');
      End;
    End;
  Finally
    FreeAndNil(qryUpdate);
    If Result Then
      pIniciaConferencia;
  End;
End;


procedure TfrmBaixaVolumes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If Not cdsVolumes.IsEmpty Then
  Begin
    Action := caNone;
    If fMensagem('','Deseja cancelar a operação?', ['&Sim', '&Não'], 2) = 1 Then
    Begin
      pIniciaConferencia;
    End;
  End;
end;

procedure TfrmBaixaVolumes.pIniciaConferencia;
Begin
  pSetFocus(edtAcesso);
  edtAcesso.Clear;
  edtNumObj.Clear;
  cdsVolumes.EmptyDataSet;
End;

procedure TfrmBaixaVolumes.FormCreate(Sender: TObject);
begin
  inherited;
  cdsVolumes := TZClient.Create(Self);
  With cdsVolumes.qryQuery, SQL Do
  Begin
    Close;
    Clear;
    Add(' SELECT PLPDOC.AUTOINCREM,                             ');
    Add('        CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) NOMCLI,    ');
    Add('        CONCAT(TRA_CODTRA, "-", TRA_NOMTRA) AS NOMTRA, ');
    Add('        COB_OBJDIG AS NUMOBJ,                          ');
    Add('        GER_VOLUME AS VOLUME,                          ');
    Add('        PLD_OPECON AS OPECON                           ');
    Add(' FROM CADFIS                                           ');
    Add('    INNER JOIN PLPDOC ON PLD_NUMDOC = FIS_NUMDOC       ');
    Add('                     AND PLD_ESPDOC = FIS_ESPDOC       ');
    Add('                     AND PLD_SERIE_ = FIS_SERIE_       ');
    Add('                     AND PLD_EMPDOC = FIS_CODEMP       ');
    Add('    INNER JOIN COROBJ ON COB_NUMOBJ = PLD_NUMOBJ       ');
    Add('    INNER JOIN MOVGER ON PLD_NUMDOC = GER_NUMDOC       ');
    Add('                     AND PLD_ESPDOC = GER_ESPDOC       ');
    Add('                     AND PLD_SERIE_ = GER_SERIE_       ');
    Add('                     AND PLD_EMPDOC = GER_CODEMP       ');
    Add('    INNER JOIN CADCLI ON CLI_CODCLI = GER_CODCLI       ');
    Add('    INNER JOIN CADTRA ON TRA_CODTRA = GER_CODTRA       ');
    Add(' WHERE FIS_ACESSO = :ACESSO                            ');
    Add('   AND FIS_CODEMP = :CODEMP                            ');

  End;

  dbtNomCli.DataSource := cdsVolumes.dtsSource;
  dbtNomTra.DataSource := cdsVolumes.dtsSource;
  dbtVolume.DataSource := cdsVolumes.dtsSource;
  dbgDados.DataSource  := cdsVolumes.dtsSource;

end;

procedure TfrmBaixaVolumes.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsVolumes);
  inherited;
end;

function TfrmBaixaVolumes.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);
  If Result Then
  Begin
    If (Sender = edtAcesso) And blnBuscaPorChave Then
    Begin
      cdsVolumes.qryQuery.Close;
      cdsVolumes.qryQuery.ParamByName('ACESSO').AsString := edtAcesso.Text;
      cdsVolumes.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
      cdsVolumes.fAbreClient(True, 'TfrmBaixaVolumes.fValidaCampos');
      cdsVolumes.FieldByName('NUMOBJ').OnGetText := pGetTextNumObj;

      intQtdCon := 0;
      Result := Not cdsVolumes.IsEmpty;
      btnConfirma.Enabled := False;

      If Not Result Then
      Begin
        edtAcesso.Clear;
        fMensagem('', 'Documento não encontrado!', ['&OK']);
      End;

    End
    Else If (Sender = edtNumObj) And blnBuscaPorChave Then
    Begin
      If cdsVolumes.Locate('NUMOBJ', edtNumObj.Text, []) Then
      Begin
        If cdsVolumes.FieldByName('OPECON').AsString = '' Then
        Begin
          Inc(intQtdCon);
          cdsVolumes.Edit;
          cdsVolumes.FieldByName('OPECON').AsString := strLoginUsuarioLogado;
          cdsVolumes.Post;
        End;

        btnConfirma.Enabled := (intQtdCon = cdsVolumes.RecordCount);
        Result := btnConfirma.Enabled;

        edtNumObj.Clear;

      End
      Else
      Begin
        Result := fMensagem('', 'Objeto não pertence a nota carregada, confira a(s) embalagem(s)!', ['&OK']) = -1;
      End;

    End;

  End;

  If not Result Then
    pSetFocus(Sender);

end;

procedure TfrmBaixaVolumes.pGetTextNumObj(Sender: TField; var Text: String; Display: Boolean);
begin
  If (Not cdsVolumes.IsEmpty) And fEmptyStr(cdsVolumes.FieldByName('OPECON').AsString) Then
    Text := '*************'
  Else
    Text := Sender.AsString;
end;

end.
