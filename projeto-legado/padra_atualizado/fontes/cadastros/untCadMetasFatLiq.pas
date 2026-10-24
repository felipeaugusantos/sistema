unit untCadMetasFatLiq;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, DBClient, Provider,
  AppEvnts, Menus, StdCtrls, EditFocus, Mask, Uni,
  MaskEditFocus, Grids, DBGrids, Buttons, ExtCtrls,
  untFuncoesSimples, StrUtils, untModulo, BitBtnLockedIncrem, untConsultas,
  untFuncoesConsulta, UniClientDataSet, UniDataSetProvider, MemDS, DBAccess,
  frxClass, frxExportCSVTestabilidade, DBGridCitel;

type  
  TfrmCadMetasFatLiq = class(TfrmPaiOrdena)
    pnlMesAnoOrigem: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    mskDtaOrigem: TMaskEditFocus;
    Label2: TLabel;
    mskDtaAtual: TMaskEditFocus;
    btnConfirmar: TBitBtnLocked;
    btnCopiarMetas: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCopiarMetasClick(Sender: TObject);
    procedure mskDtaOrigemExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgConsultaEnter(Sender: TObject);
  private
    { Private declarations }
    strMesAno   : String;
    strMesAnoOri: String;

    procedure pCopiaMeta;
    procedure pCopiaMetaCadMet;
    procedure pIncluiRegistros;
    procedure pAbreConsulta(blnInciar: Boolean);

  public
    { Public declarations }
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untPai;

{$R *.dfm}

procedure TfrmCadMetasFatLiq.FormCreate(Sender: TObject);
begin
  inherited;

  mskDtaAtual.Text := FormatDateTime('mm/yyyy', VS_Date);
  strMesAno        := AnsiReplaceStr(mskDtaAtual.Text, '/', '');
end;

procedure TfrmCadMetasFatLiq.pIncluiRegistros;
  Var
    qryCadMet: TUniquery;
    qryCadIns: TUniquery;
Begin
  qryCadIns := fCriaQuery;
  With qryCadIns, SQL Do
  Begin
    Clear;
    Add(' INSERT INTO CADMLQ ');
    Add('  (AUTOINCREM, MET_MESANO, MET_CODVEN, MET_TOTMET) ');
    Add(' VALUES');
    Add('  (:AUTOIN, :MESANO, :CODVEN, 0) ');
  End;

  qryCadMet := fCriaQuery;
  With qryCadMet, SQL Do
  Begin
    Clear;
    Add(' SELECT OPE_CODOPE FROM CADOPE ');
    Add(' LEFT JOIN CADMLQ ON           ');
    Add('   OPE_CODOPE = MET_CODVEN AND ');
    Add('   MET_MESANO = :MESANO        ');
    Add(' WHERE                         ');
    Add('   MET_CODVEN IS NULL AND      ');
    Add('   OPE_INTEXT IN ("I","E","D","G") ');
    ParamByName('MESANO').AsString := strMesAno;

    Open;

    While Not Eof Do
    Begin
      qryCadIns.Close;
      qryCadIns.ParamByName('CODVEN').AsString := FieldByName('OPE_CODOPE').AsString;
      qryCadIns.ParamByName('MESANO').AsString := strMesAno;
      qryCadIns.ParamByName('AUTOIN').AsString := fRetAutoIncrem('CADMLQ', VS_strCodEmp);
      qryCadIns.ExecSQL;
      Next;
    End;

    Close;

  End;
  FreeAndNil(qryCadMet);
  FreeAndNil(qryCadIns);
End;

function TfrmCadMetasFatLiq.fGetSql(blnLike: Boolean): String;
  procedure pAdd(strSQL: String);
  Begin
    Result := Result + IIF(fEmptyStr(Result), '', #13#10) + strSQL;
  End;
Begin
  Result := '';

  pAdd('SELECT');
  pAdd('  M.*,');
  pAdd('  OPE_NOMOPE AS NOMOPE,');
  pAdd('  (SELECT G.OPE_NOMOPE FROM CADOPE G WHERE G.OPE_CODOPE = O.OPE_CODGER) AS GERENT,');
  pAdd('  (SELECT S.OPE_NOMOPE FROM CADOPE S WHERE S.OPE_CODOPE = O.OPE_CODSUB) AS SUBGER,');
  pAdd('  CASE');
  pAdd('    WHEN IFNULL(O.OPE_GERENT, "N") = "S" THEN "GERENTE"');
  pAdd('    WHEN IFNULL(O.OPE_SUBGER, "N") = "S" THEN "SUB-GERENTE"');
  pAdd('    WHEN O.OPE_INTEXT = "E" THEN "REPRES. EXTERNO LOJA"');
  pAdd('    WHEN O.OPE_INTEXT = "D" THEN "REPRES. EXTERNO DISTRIBUIDOR"');
  pAdd('    ELSE "VENDEDOR"');
  pAdd('  END AS FUNCAO');
  pAdd('FROM');
  pAdd('  CADMLQ M');
  pAdd('  LEFT JOIN CADOPE O ON O.OPE_CODOPE = MET_CODVEN');
  pAdd('WHERE');
  pAdd('  M.MET_MESANO = :MESANO    AND');
  pAdd('  O.OPE_STATUS = "A"        AND');
  pAdd('  O.OPE_INTEXT IN ("I","E","D","G","S") ');
  pAdd('GROUP BY');
  pAdd('  MET_MESANO,');
  pAdd('  MET_CODVEN');
End;

procedure TfrmCadMetasFatLiq.pAbreConsulta(blnInciar: Boolean);
Begin
  If cdsConsulta.Active Then
    cdsConsulta.CancelUpdates;

  pIncluiRegistros;
  fAbreConsulta;
End;

procedure TfrmCadMetasFatLiq.FormShow(Sender: TObject);
begin
  inherited;
  blnSempreRelerBanco := False;
  blnTemSelecao       := False;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  pAbreConsulta(True);

  pSetFocus(mskDtaAtual);
end;

procedure TfrmCadMetasFatLiq.btnConfirmarClick(Sender: TObject);
  Var
    intNroErr: Integer;
begin
  inherited;

  If fMensagem('','Confirma a gravação das metas?',['&Sim','&Não']) = 2 Then
    Exit;

  Try

    fStartTransaction;

    intNroErr := cdsConsulta.ApplyUpdates(-1);

    If intNroErr = 0 Then
    Begin
      fCommit;
      fMensagem('', 'Metas atualizadas com sucesso!', ['&O k']);
    End
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

procedure TfrmCadMetasFatLiq.btnCopiarMetasClick(Sender: TObject);
begin
  inherited ;

  pnlMesAnoOrigem.Visible := True;
  blnMudarFoco := True;
  pSetFocus(mskDtaOrigem);

end;

procedure TfrmCadMetasFatLiq.dbgConsultaEnter(Sender: TObject);
begin
  inherited;
  If cdsConsulta.Active Then
    dbgConsulta.SelectedField := cdsConsulta.FieldByName('MET_TOTMET');
end;

procedure TfrmCadMetasFatLiq.pCopiaMeta;
Begin
  cdsConsulta.DisableControls;

  Try
    pCopiaMetaCadMet;
  Except
  	On E: Exception Do
    Begin
    	pMensagensErro(E.Message,'[pCopiaMeta]');
    End;
  End;

  cdsConsulta.First;
  cdsConsulta.EnableControls;
End;

procedure TfrmCadMetasFatLiq.pCopiaMetaCadMet;
  Var
    qryCadMet: TUniquery;
Begin

  qryCadMet := fCriaQuery;
  With qryCadMet, SQL Do
  Begin
    Clear;
    Add(' SELECT * FROM CADMLQ   ');
    Add(' WHERE MET_MESANO = :MESANO ');

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

procedure TfrmCadMetasFatLiq.mskDtaOrigemExit(Sender: TObject);
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

    pnlMesAnoOrigem.Visible := False;
    pSetFocus(dbgConsulta);
  End;

end;

function TfrmCadMetasFatLiq.fSetParametros: Boolean;
begin
  Result := True;
  qryConsulta.ParamByName('MESANO').AsString := strMesAno;
end;

function TfrmCadMetasFatLiq.fValidaCampos(Sender: TWinControl;
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
          mskDtaAtual.Text := fTrataAnoDataMesAno(mskDtaAtual.Text);
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

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadMetasFatLiq.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_F10 : btnConfirmar.Click;

    VK_F11 : btnCopiarMetas.Click;

    VK_ESCAPE: If (Not (cdsConsulta.State in [dsInsert, dsEdit])) And
                  (Not pnlPesquisa.Visible) And (Not mskDtaAtual.Focused) Then
               Begin
                 pSetFocus(mskDtaAtual);
                 abort;
               End
               Else inherited;

    Else inherited;
  End;
end;

procedure TfrmCadMetasFatLiq.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If CharInSet(Key,['-','+']) Then
    Key := #0;
end;

procedure TfrmCadMetasFatLiq.FormClose(Sender: TObject;
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
