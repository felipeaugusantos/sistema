unit untCadMetasLitGal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
   Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  untFuncoesSimples, StrUtils, untModulo;

type
  TfrmCadMetasLitGal = class(TfrmPaiOrdena)
    pnlMesAnoOrigem: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    mskDtaOrigem: TMaskEditFocus;
    Label2: TLabel;
    mskDtaAtual: TMaskEditFocus;
    qryConsultaCODVEN: TStringField;
    qryConsultaTOTMET: TFloatField;
    qryCadVen: TUniQuery;
    qryConsultaNOMVEN: TStringField;
    qryConsultaAUTOINCREM: TStringField;
    btnConfirmar: TBitBtn;
    btnCopiarMetas: TBitBtn;
    Splitter1: TSplitter;
    DataSource1: TDataSource;
    qryConsultaMET_MESANO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCopiarMetasClick(Sender: TObject);
    procedure mskDtaOrigemExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure pnlTailEnter(Sender: TObject);
    procedure pnlTailExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    strMesAno   : String;
    strMesAnoOri: String;

    procedure pCopiaMeta;
    procedure pCopiaMetaCadMet;
    procedure pCopiaMetaDetMet;
    procedure pIncluiRegistros;
    procedure pSetaFiltro;
    procedure pAbreConsulta(blnInciar: Boolean);

  public
    { Public declarations }
    blnPorGrupo: Boolean;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadMetasLitGal: TfrmCadMetasLitGal;

implementation

uses untPai, untCadMetasGrupo;

{$R *.dfm}

procedure TfrmCadMetasLitGal.FormCreate(Sender: TObject);
begin
  inherited;

  blnPorGrupo := False;
   
  mskDtaAtual.Text := FormatDateTime('mm/yyyy', VS_Date);
  strMesAno        := AnsiReplaceStr(mskDtaAtual.Text, '/', '');

  qryCadVen.Open;

end;

procedure TfrmCadMetasLitGal.pIncluiRegistros;
  Var
    qryCadMet: TUniQuery;
    qryCadIns: TUniQuery;
Begin
  qryCadIns := fCriaQuery;
  With qryCadIns, SQL Do
  Begin
    Clear;
    Add(' INSERT INTO CADMET');
    Add('  (AUTOINCREM, MET_MESANO, MET_CODEMP, MET_CODVEN, MET_TOTMET) ');
    Add(' VALUES');
    Add('  (:AUTOIN, :MESANO, :CODEMP, :CODVEN, 0) ');
  End;

  qryCadMet := fCriaQuery;
  With qryCadMet, SQL Do
  Begin
    Clear;
    Add(' SELECT OPE_CODOPE FROM CADOPE ');
    Add(' LEFT JOIN CADMET ON           ');
    Add('   OPE_CODOPE = MET_CODVEN AND ');
    Add('   MET_MESANO = :MESANO    AND ');
    Add('   MET_CODEMP = :CODEMP        ');
    Add(' WHERE                         ');
    Add('   MET_CODVEN IS NULL          ');

    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('MESANO').AsString := strMesAno;

    Open;

    While Not Eof Do
    Begin
      qryCadIns.Close;
      qryCadIns.ParamByName('CODVEN').AsString := FieldByName('OPE_CODOPE').AsString;
      qryCadIns.ParamByName('MESANO').AsString := strMesAno;
      qryCadIns.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryCadIns.ParamByName('AUTOIN').AsString := fRetAutoIncrem('CADMET', VS_strCodEmp);
      qryCadIns.ExecSQL;
      Next;
    End;

    Close;

  End;
  FreeAndNil(qryCadMet);
  FreeAndNil(qryCadIns);
End;

function TfrmCadMetasLitGal.fGetSql(blnLike: Boolean): String;
Begin
  Result := '';
  Result := Result + ' SELECT * FROM CADMET';
  Result := Result + ' WHERE MET_MESANO = ' + QuotedStr(strMesAno);
End;

procedure TfrmCadMetasLitGal.pAbreConsulta(blnInciar: Boolean);
Begin
  If cdsConsulta.Active Then
    cdsConsulta.CancelUpdates;

  pIncluiRegistros;
  fAbreConsulta;

  If blnPorGrupo Then
  Begin
    frmCadMetasGrupo.strMesAno := strMesAno;

    If blnInciar Then
    Begin
      frmCadMetasGrupo.Dock(pnlTail,pnlTail.BoundsRect);
      frmCadMetasGrupo.Show;
    End

    Else frmCadMetasGrupo.pAbreConsulta;

    cdsConsulta.FieldByName('MET_TOTMET').FocusControl;

    pSetaFiltro;
  End;

End;

procedure TfrmCadMetasLitGal.FormShow(Sender: TObject);
begin
  inherited;

  blnSempreRelerBanco := False;
  blnTemSelecao       := False;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  pnlTail.Visible := blnPorGrupo;

  If blnPorGrupo Then
    pCriarFormularios(TfrmCadMetasGrupo, frmCadMetasGrupo);

  pAbreConsulta(True);


end;

procedure TfrmCadMetasLitGal.btnConfirmarClick(Sender: TObject);
  Var
    intNroErr: Integer;
begin
  inherited;

  If fMensagem('','Tem certeza que deseja gravar estas metas?',['&Sim','&Não']) = 2 Then
    Exit;

  Try

    fStartTransaction;

    intNroErr := cdsConsulta.ApplyUpdates(-1);

    If blnPorGrupo And (intNroErr = 0) Then
      intNroErr := frmCadMetasGrupo.cdsConsulta.ApplyUpdates(-1);

    If intNroErr = 0 Then
      fCommit
    Else
      fRollBack;
      
  Except
    On E : Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[pGravarMetas]');
    End;
  End;  

  pnlMesAnoOrigem.Visible := False;

end;

procedure TfrmCadMetasLitGal.btnCopiarMetasClick(Sender: TObject);
begin
  inherited;

  pnlMesAnoOrigem.Visible := True;
  blnMudarFoco := True;
  mskDtaOrigem.SetFocus;

end;

procedure TfrmCadMetasLitGal.pCopiaMeta;
Begin
  cdsConsulta.DisableControls;
  
  Try
    pCopiaMetaCadMet;

    If blnPorGrupo Then
      pCopiaMetaDetMet;
  Except
  	On E: Exception Do
    Begin
      If blnPorGrupo Then
        frmCadMetasGrupo.cdsConsulta.Tag := 0;

    	pMensagensErro(E.Message,'[pCopiaMeta]');
    End;
  End;

  cdsConsulta.First;


  If blnPorGrupo Then
    pSetaFiltro;

  cdsConsulta.EnableControls;
End;

procedure TfrmCadMetasLitGal.pCopiaMetaDetMet;
  Var
    qryDetMet: TUniQuery;
Begin

  qryDetMet := fCriaQuery;
  With qryDetMet, SQL Do
  Begin
    Clear;
    Add(' SELECT * FROM DETMET ');
    Add(' WHERE                   ');
    Add('   MET_MESANO = :MESANO  ');

    ParamByName('MESANO').AsString := strMesAnoOri;

    Open;
  End;

  With frmCadMetasGrupo.cdsConsulta Do
  Begin
    DisableControls;
    Tag := 1;
    EmptyDataSet;

    While Not qryDetMet.Eof Do
    Begin
    
      Insert;
      FieldByName('MET_CODVEN').AsString := qryDetMet.FieldByName('MET_CODVEN').AsString;
      FieldByName('MET_CODEMP').AsString := qryDetMet.FieldByName('MET_CODEMP').AsString;
      FieldByName('MET_CODGRU').AsString := qryDetMet.FieldByName('MET_CODGRU').AsString;
      FieldByName('MET_PERGRU').AsString := qryDetMet.FieldByName('MET_PERGRU').AsString;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DETMET', VS_strCodEmp);
      FieldByName('MET_MESANO').AsString := strMesAno;
      Post;

      qryDetMet.Next;
    End;

    Tag := 0;

    EnableControls;
  End;

  FreeAndNil(qryDetMet);
End;

procedure TfrmCadMetasLitGal.pCopiaMetaCadMet;
  Var
    qryCadMet: TUniQuery;
Begin

  qryCadMet := fCriaQuery;
  With qryCadMet, SQL Do
  Begin
    Clear;
    Add(' SELECT * FROM CADMET ');
    Add(' WHERE                   ');
    Add('   MET_MESANO = :MESANO  ');

    ParamByName('MESANO').AsString := strMesAnoOri;

    Open;

    While Not Eof Do
    Begin
      If cdsConsulta.Locate('MET_CODVEN', FieldByName('MET_CODVEN').AsString, []) Then
      Begin
        cdsConsulta.Edit;
        cdsConsulta.FieldByName('MET_TOTMET').AsFloat := FieldByName('MET_TOTMET').AsFloat;
        cdsConsulta.Post;
      End;

      Next;
    End;

  End;

  FreeAndNil(qryCadMet);
End;

procedure TfrmCadMetasLitGal.mskDtaOrigemExit(Sender: TObject);
  Var
    strAno: String;
    strMes: String;
begin
  inherited;

  //**********************************************//
  // COMPLETA O ANO PARA 4 DÍGITOS CASO O USUÁRIO //
  // DIGITE APENAS DOIS DÍGITOS NO ANO. EX:       //
  // SE FOR DIGITADO 07, COMPLETA PARA 2007       //
  //*******************************************RL*//
  If (RightStr(mskDtaOrigem.Text,4) <> '') And (LeftStr(mskDtaOrigem.Text,2) <> '') Then
  Begin
    strMes := Trim(LeftStr(mskDtaOrigem.Text,2));
    strAno := Trim(RightStr(mskDtaOrigem.Text,4));

    If Length(strAno) = 1 Then
      mskDtaOrigem.Text := strMes + '/200' + strAno
    Else If Length(strAno) = 2 Then
      mskDtaOrigem.Text := strMes + '/20' + strAno
    Else If Length(strAno) = 3 Then
      mskDtaOrigem.Text := strMes + '/2' + strAno;

    strMesAnoOri := AnsiReplaceStr(mskDtaOrigem.Text, '/', '');

    pCopiaMeta;
  End;

end;

function TfrmCadMetasLitGal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {**************************************}
    {* VALIDA DATA DE ORIGEM              *}
    {***********************************RL*}
    If (Sender = mskDtaOrigem) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaOrigem.Text)) Then
      Begin
        fMensagem('', 'Informar o mês / ano de origem !', ['&O k']);
        Result := False;
      End
      Else
      Begin

        Try
          strToDate('01/' + mskDtaOrigem.Text);
        Except
          fMensagem('', 'Mês / Ano inválido !', ['&O k']);
          Result := False;
        End;

      End;

    End

    {**************************************}
    {* VALIDA DATA ATUAL                  *}
    {***********************************RL*}
    Else If (Sender = mskDtaAtual) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaAtual.Text)) Then
      Begin
        fMensagem('', 'Informar o mês / ano atual !', ['&O k']);
        Result := False;
      End
      Else
      Begin

        Try
          strToDate('01/' + mskDtaAtual.Text);

          If Not SameText(fTiraCaracEspeciais(mskDtaAtual.Text), strMesAno) Then
          Begin
            strMesAno := fTiraCaracEspeciais(mskDtaAtual.Text);
            cdsConsulta.Close;
            pAbreConsulta(False);
          End;

        Except
          fMensagem('', 'Mês / Ano inválido !', ['&O k']);
          Result := False;
        End;

      End;
    End


  End;

  If Not Result Then
    Sender.SetFocus;
end;

procedure TfrmCadMetasLitGal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  
  Case Key Of
    VK_F10 : btnConfirmar.Click;
    VK_F11 : btnCopiarMetas.Click;
  End;

end;

procedure TfrmCadMetasLitGal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If Key = '-' Then
    Key := #0;

end;

procedure TfrmCadMetasLitGal.FormDestroy(Sender: TObject);
begin
  inherited;

  If blnPorGrupo Then
    pFreeAndNil(frmCadMetasGrupo);

end;

procedure TfrmCadMetasLitGal.pSetaFiltro;
Begin
  frmCadMetasGrupo.cdsCadMet            := cdsConsulta;
  frmCadMetasGrupo.cdsConsulta.Filter   := 'MET_MESANO = ' + QuotedStr(cdsConsulta.FieldByName('MET_MESANO').AsString) +
                                           ' AND MET_CODVEN = ' + QuotedStr(cdsConsulta.FieldByName('MET_CODVEN').AsString);
  frmCadMetasGrupo.cdsConsulta.Filtered := True;
End;

procedure TfrmCadMetasLitGal.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;

  If blnPorGrupo Then
    pSetaFiltro;

end;

procedure TfrmCadMetasLitGal.pnlTailEnter(Sender: TObject);
begin
  inherited;

  blnMudarFoco := False;

end;

procedure TfrmCadMetasLitGal.pnlTailExit(Sender: TObject);
begin
  inherited;

  blnMudarFoco := True;
end;

procedure TfrmCadMetasLitGal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  cdsConsulta.CancelUpdates;

  If pnlMesAnoOrigem.Visible Then
  Begin
    pnlMesAnoOrigem.Visible := False;
    Action := caNone;

    pAbreConsulta(False);
  End;


end;

end.
