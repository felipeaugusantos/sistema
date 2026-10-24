unit untCadMetasGalonagem;

interface

uses
  Windows, Classes, Controls, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, UniClientDataSet,
  UniDataSetProvider, Uni, Mask, MaskEditFocus, EditFocus, cxDBLookupComboBox,
  untModulo, BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess, Provider,
  frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient;

type
  TfrmCadMetasGalonagem = class(TfrmPaiEdit)
    pnlPeriodo: TPanel;
    Splitter1: TSplitter;
    qryForDet: TUniQuery;
    dspForDet: TUniDataSetProvider;
    cdsForDet: TUniClientDataSet;
    dtsForDet: TDataSource;
    qryForGer: TUniQuery;
    dspForGer: TUniDataSetProvider;
    cdsForGer: TUniClientDataSet;
    dtsForGer: TDataSource;
    Label2: TLabel;
    mskDtaAtual: TMaskEditFocus;
    Label3: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    qryCadGru: TUniQuery;
    dtsCadGru: TDataSource;
    qryCadFor: TUniQuery;
    dtsCadFor: TDataSource;
    cdsForDetTOT_PERGRU: TAggregateField;
    cdsForGerTOT_TOTGAL: TAggregateField;
    pnlGruFor: TPanel;
    Panel2: TPanel;
    cxgFornecedores: TcxGrid;
    cxgFornecedoresDBTableView1: TcxGridDBTableView;
    cxgFornecedoresDBTableView1Column1: TcxGridDBColumn;
    cxgFornecedoresDBTableView1Column2: TcxGridDBColumn;
    cxgFornecedoresDBTableView1Column3: TcxGridDBColumn;
    cxgFornecedoresLevel1: TcxGridLevel;
    pnlFornecedor: TPanel;
    Label1: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    edtTotGal: TEditFocus;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtGalGer: TEditFocus;
    pnlGruProd: TPanel;
    Panel3: TPanel;
    cxgGrupos: TcxGrid;
    cxgGruposDBTableView1: TcxGridDBTableView;
    cxgGruposDBTableView1Column1: TcxGridDBColumn;
    cxgGruposDBTableView1Column2: TcxGridDBColumn;
    cxgGruposDBTableView1Column3: TcxGridDBColumn;
    cxgGruposLevel1: TcxGridLevel;
    pnlGrupo: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    edtPerGru: TEditFocus;
    edtTotPer: TEditFocus;
    shpLiberado: TShape;
    btnConfirmar: TBitBtnLocked;
    btnCopMet: TBitBtnLocked;
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
    procedure cdsForDetAfterScroll(DataSet: TDataSet);
    procedure cdsForDetAfterPost(DataSet: TDataSet);
    procedure cdsForGerAfterScroll(DataSet: TDataSet);
    procedure btnSairClick(Sender: TObject);
    procedure cdsForGerBeforePost(DataSet: TDataSet);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cxgGruposDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgFornecedoresDBTableView1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure btnCopMetClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    strMesAno: String;
    strCodVen: String;
    intNumMes: Integer;
    intNumAno: Integer;
    strCodGru: String;
    blnLiberado: Boolean;

    function fAbreConsulta: Boolean;
    function fValidaMesAno: Boolean;
    function fValidaVendedor: Boolean;
    function fValidaFornecedor(blnBuscaPorChave: Boolean): Boolean;
    function fValidaGrupo(blnBuscaPorChave: Boolean): Boolean;
    function fValidaPercentual: Boolean;
    function fValidaTotalFornecedor: Boolean;
    function fRetTotPerGru: Double;
    Function fValidaTotalGrupo: Boolean;
    Function fValidaGrupos: Boolean;
    function fRetTotGal: Double;
    Function fGravaMetas(blnConfirma: Boolean = True): Boolean;

    Procedure pAbreCadGru;
    Procedure pAbreCadFor;
    Procedure pAbreForGer;
    Procedure pAbreForDet;
    procedure pCarregaRegistroGrupo;
    procedure pCarregaRegistroFornecedor;
    Procedure pLimpaDadosDet(blnSetFocus: Boolean = True);
    Procedure pLimpaDadosGer(blnSetFocus: Boolean = True);
    procedure pAtualizaTotPer;
    Procedure pAtualizaTotGal;
    procedure pSetaFiltro;
    Procedure pIniciaConsulta;
    Procedure pFechaConsulta;

    procedure pCopiaMetas;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses SysUtils, Variants, Graphics, Math, Forms, StrUtils, untPai, untTypesSistema,
  untFuncoesSimples, untCadMetasGalonCopia, untConsultas;

{$R *.dfm}

Procedure TfrmCadMetasGalonagem.pAbreCadFor;
Begin
  With qryCadFor, SQL Do
  Begin
    Clear;
    Add('SELECT ');
    Add('  FOR_CODFOR, ');
    Add('  FOR_NOMFOR  ');
    Add('FROM          ');
    Add('  CADFOR      ');
    Open;
  End;
End;

Procedure TfrmCadMetasGalonagem.pAbreCadGru;
Begin
  With qryCadGru, SQL Do
  Begin
    Clear;
    Add('SELECT ');
    Add('  GRU_CODGRU, ');
    Add('  GRU_DESGRU  ');
    Add('FROM          ');
    Add('  CADGRU      ');
    Open;
  End;
End;

Procedure TfrmCadMetasGalonagem.pAbreForGer;
Begin
  With qryForGer, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add('  *   ');
    Add('FROM');
    Add('  FORGER');
    Add('WHERE');
    Add('  GER_NUMMES = :NUMMES AND ');
    Add('  GER_NUMANO = :NUMANO AND ');
    Add('  GER_CODVEN = :CODVEN     ');

    Close;
    ParamByName('NUMMES').AsInteger := intNumMes;
    ParamByName('NUMANO').AsInteger := intNumAno;
    ParamByName('CODVEN').AsString  := strCodVen;

    cdsForGer.Close;
    cdsForGer.Open;

    (cdsForGer.FieldByName('GER_TOTGAL') As TFloatField).DisplayFormat := '#,##0.00';

    pLimpaDadosGer(False);
  End;
End;

Procedure TfrmCadMetasGalonagem.pAbreForDet;
Begin
  With qryForDet, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add(' D.*  ');
    Add('FROM');
    Add('  FORDET D');
    Add('INNER JOIN FORGER G ON          ');
    Add('  DET_SEQGER = G.AUTOINCREM AND ');
    Add('  GER_NUMMES = :NUMMES AND ');
    Add('  GER_NUMANO = :NUMANO AND ');
    Add('  GER_CODVEN = :CODVEN     ');

    Close;
    ParamByName('NUMMES').AsInteger := intNumMes;
    ParamByName('NUMANO').AsInteger := intNumAno;
    ParamByName('CODVEN').AsString  := strCodVen;

    cdsForDet.Close;
    cdsForDet.Open;

    (cdsForDet.FieldByName('DET_PERGRU') As TFloatField).DisplayFormat := '#,##0.00';
    cdsForDet.FieldByName('DET_CODGRU').EditMask := '999.999;0;';

  End;
End;

Procedure TfrmCadMetasGalonagem.pFechaConsulta;
Begin
  If cdsForGer.Active Then
  Begin
    cdsForGer.CancelUpdates;
    cdsForGer.Close;
  End;

  If cdsForDet.Active Then
  Begin
    cdsForDet.CancelUpdates;
    cdsForDet.Close;
  End;

  pAtualizaTotPer;
  pAtualizaTotGal;
End;

function TfrmCadMetasGalonagem.fAbreConsulta: Boolean;
Begin
  Try
    pAbreForGer;
    pAbreForDet;

    blnMudarFoco := False;

    pnlPeriodo.Enabled := False;

    pSetFocus(edtCodFor);

    Result := True;
  Except

    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fAbreConsulta]');
    End;

  End;
End;

function TfrmCadMetasGalonagem.fValidaMesAno: Boolean;
Begin

  Result := True;
  
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

        pFechaConsulta;
      End;

      intNumMes := StrToIntDef(LeftStr(strMesAno, 2), 0);
      intNumAno := StrToIntDef(RightStr(strMesAno, 4), 0);

    Except
      fMensagem('', 'Mês / Ano inválido !', ['&O k']);
      Result := False;
    End;

  End;

End;

function TfrmCadMetasGalonagem.fValidaVendedor: Boolean;
Begin

  Result := True;

  If fEmptyStr(edtCodVen.Text) Then
  Begin
    pMensagemOk('Informe o código do Vendedor!');
    Result := False;
  End Else
  Begin
    If blnLiberado Then
      edtNomVen.Text := fRetNomVendRep(edtCodVen.Text)
    Else
      edtNomVen.Text := fRetNomVendRep(edtCodVen.Text, VS_strCodEmp);

    If fEmptyStr(edtNomVen.Text) Or (Pos(fRetTipoOperador(edtCodVen.Text),'I_E_D_') <= 0) Then
    Begin
      pMensagemOk('Vendedor não encontrado!');
      Result := False;
    End

    Else
    Begin
      strCodVen := edtCodVen.Text;

      fAbreConsulta;
    End;

  End

End;

function TfrmCadMetasGalonagem.fValidaFornecedor(blnBuscaPorChave: Boolean): Boolean;
Begin
  Result := True;

  If fEmptyStr(edtCodFor.Text) Then
  Begin

    If qryForGer.IsEmpty Then
    Begin
      pMensagemOk('Informe o código do Fornecedor!');
      Result := False;
    End Else
    Begin
      blnMudarFoco := False;
      pLimpaDadosGer(False);
      pSetFocus(edtPerGru);
    End;

  End Else
  Begin
    edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);

    If fEmptyStr(edtNomFor.Text) Then
    Begin
      pMensagemOk('Fornecedor não encontrado!');
      Result := False;
    End Else
    Begin
      blnMudarFoco := False;

      If blnBuscaPorChave Then
      Begin
        pSetFocus(edtTotGal);

        If cdsForGer.Locate('GER_CODFOR', edtCodFor.Text, []) Then
          pCarregaRegistroFornecedor;
      End;

    End;

  End

End;

function TfrmCadMetasGalonagem.fValidaTotalFornecedor: Boolean;
Begin
  Result := True;

  If (fStrToFloat(edtTotGal.Text) <= 0) Then
  Begin
    fMensagem('', 'A Galonagem deve ser maior que zero!', ['&Ok']);
    Result := False;
  End

  Else If fValidaCampos(edtCodFor, False) Then
  Begin

    With cdsForGer Do
    If Locate('GER_CODFOR', edtCodFor.Text, []) Then
    Begin
      Edit;
      FieldByName('GER_TOTGAL').AsFloat := fStrToFloat(edtTotGal.Text);
      Post;
    End Else
    Begin

      Insert;
      FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('FORGER', VS_strCodEmp);
      FieldByName('GER_CODEMP').AsString  := VS_strCodEmp;
      FieldByName('GER_CODVEN').AsString  := strCodVen;
      FieldByName('GER_CODFOR').AsString  := edtCodFor.Text;
      FieldByName('GER_NUMANO').AsInteger := intNumAno;
      FieldByName('GER_NUMMES').AsInteger := intNumMes;
      FieldByName('GER_TOTGAL').AsFloat   := fStrToFloat(edtTotGal.Text);
      Post;

    End;

    If Result Then
      pLimpaDadosGer;

  End;

End;

Procedure TfrmCadMetasGalonagem.pLimpaDadosGer(blnSetFocus: Boolean = True);
Begin
  edtCodFor.Clear;
  edtNomFor.Clear;

  edtTotGal.Text := FormatFloat('#,##0.00', 0);

  pLimpaDadosDet(blnSetFocus);
End;

procedure TfrmCadMetasGalonagem.pCarregaRegistroGrupo;
Begin

  With cdsForDet Do
  Begin
    mskLinhaGrupo.Text := FieldByName('DET_CODGRU').AsString;
    edtDesGrupo.Text   := fRetNomeLinhaGrupo(fTiraCaracEspeciais(FieldByName('DET_CODGRU').AsString));
    edtPerGru.Text     := FormatFloat('#,##0.00', FieldByName('DET_PERGRU').AsFloat);
  End;

End;

procedure TfrmCadMetasGalonagem.pCarregaRegistroFornecedor;
Begin

  With cdsForGer Do
  Begin
    edtCodFor.Text := FieldByName('GER_CODFOR').AsString;
    edtNomFor.Text := fRetNomFornecedor(FieldByName('GER_CODFOR').AsString);
    edtTotGal.Text := FormatFloat('#,##0.00', FieldByName('GER_TOTGAL').AsFloat);
  End;

End;

function TfrmCadMetasGalonagem.fRetTotPerGru: Double;
Begin
  If (Not cdsForDet.Active) Or (TAggregateField(cdsForDet.FieldByName('TOT_PERGRU')).Value = Null) Then
    Result := 0
  Else
    Result := TAggregateField(cdsForDet.FieldByName('TOT_PERGRU')).Value;
End;

function TfrmCadMetasGalonagem.fValidaGrupo(blnBuscaPorChave: Boolean): Boolean;
  Var
    strDesGru,
    strCodGru: String;
    blnBloqueia : Boolean;
Begin
  Result      := True;
  blnBloqueia := false;

  If fEmptyStr(fTiraCaracEspeciais(mskLinhaGrupo.Text)) Then
  Begin
    fMensagem('', 'Informe o Grupo de Produtos para a meta!', ['&Ok']);
    Result := False;
  End

  Else
  Begin
    strCodGru := fTiraCaracEspeciais(mskLinhaGrupo.Text);
    strDesGru := fRetNomeLinhaGrupo(strCodGru);

    If fEmptyStr(strDesGru) Then
    Begin
      fMensagem('', 'Grupo de Produtos não encontrado!', ['&Ok']);
      Result := False;
    End

    Else

    Begin
      edtDesGrupo.Text := strDesGru;
      blnMudarFoco := False;

      With cdsForDet Do
      Begin
        {**********************************************************}
        {* LOCALIZA REGISTROS ADICIONADOS COM A MESMA LINHA       *}
        {* QUE FOI DIGITADA NO mskLinhaGrupo E TESTA              *}
        {******************************************************MM**}
        If (RecordCount > 0) Then
        Begin
          First;
          While Not EOF DO
          Begin
            If (Copy(FieldByName('DET_CODGRU').AsString,1,3) = Copy(strCodGru,1,3)) Then
            Begin
              if ((Copy(strCodGru,4,3) <> '000') And (Copy(FieldByName('DET_CODGRU').AsString,4,3) = '000')) Or
                 ((Copy(strCodGru,4,3)  = '000') And (Copy(FieldByName('DET_CODGRU').AsString,4,3)<> '000')) Then
              Begin
                blnBloqueia := True;
              End;
            End;

            Next;
          End;
        End;

        {**********************************************************}
        {* BLOQUEIA A INSERÇÃO DE UM GRUPO CASO SUA LINHA         *}
        {* JÁ TENHA SIDO INSERIDA OU BLOQUEIA A INSERÇÃO DE       *}
        {* UMA LINHA CASO UM GRUPO DA MESMA JÁ TENHA SIDO INSERIDO*}
        {******************************************************MM**}
        If (blnBloqueia) Then
        Begin
          If (Copy(strCodGru,4,3) <> '000') Then
          Begin
            fMensagem('', 'A Linha deste Grupo já foi inserida!', ['&Ok']);
            Result := False;
            Exit;
          End
          Else If (Copy(strCodGru,4,3) = '000') Then
          Begin
            fMensagem('', 'Um Grupo desta Linha já foi inserido!', ['&Ok']);
            Result := False;
            Exit;
          End;
        End;
      End;

      If blnBuscaPorChave Then
      Begin
        pSetFocus(edtPerGru);
        strCodGru := fTiraCaracEspeciais(mskLinhaGrupo.Text);

        If cdsForDet.Locate('DET_CODGRU', strCodGru, []) Then
          pCarregaRegistroGrupo
        Else
          edtPerGru.Text :=  FormatFloat('#,##0.00', 100 - fRetTotPerGru);
      End;

    End;

  End;

End;

Procedure TfrmCadMetasGalonagem.pLimpaDadosDet(blnSetFocus: Boolean = True);
Begin

  If blnSetFocus Then
  Begin
    blnMudarFoco := False;
    pSetFocus(mskLinhaGrupo);
  End;

  mskLinhaGrupo.Clear;
  edtDesGrupo.Clear;
  edtPerGru.Text := FormatFloat('#,##0.00', 0);
End;

function TfrmCadMetasGalonagem.fValidaPercentual: Boolean;
Begin
  Result := True;

  If (fStrToFloat(edtPerGru.Text) <= 0) Or
     (fStrToFloat(edtPerGru.Text) > 100) Then
  Begin
    fMensagem('', 'O percentual deve ser maior que zero e menor ou igual a 100!', ['&Ok']);
    Result := False;
  End

  Else If fValidaCampos(mskLinhaGrupo, False) Then
  Begin
    strCodGru := fTiraCaracEspeciais(mskLinhaGrupo.Text);

    If cdsForGer.IsEmpty Then
    Begin
      fMensagem('', 'Inclua o Fornecedor para a meta!', ['&Ok']);
      Result := False;
    End Else

    With cdsForDet Do
    If Locate('DET_CODGRU', strCodGru, []) Then
    Begin
      If RoundTo(fRetTotPerGru - FieldByName('DET_PERGRU').AsFloat + fStrToFloat(edtPerGru.Text), -2) > 100 Then
      Begin
        fMensagem('', 'A Soma dos grupos dever igual a 100%!', ['&Ok']);
        Result := False;
      End Else
      Begin
        Edit;
        FieldByName('DET_PERGRU').AsFloat := RoundTo(fStrToFloat(edtPerGru.Text), -2);
        Post;
      End;

    End Else
    Begin

      If RoundTo(fRetTotPerGru + fStrToFloat(edtPerGru.Text), -2) > 100 Then
      Begin
        fMensagem('', 'A Soma dos grupos dever ser igual a 100!', ['&Ok']);
        Result := False;
      End Else
      Begin
        Insert;
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FORDET', VS_strCodEmp);
        FieldByName('DET_CODEMP').AsString := VS_strCodEmp;
        FieldByName('DET_SEQGER').AsString := cdsForGer.FieldByName('AUTOINCREM').AsString;
        FieldByName('DET_CODGRU').AsString := strCodGru;
        FieldByName('DET_PERGRU').AsFloat  := RoundTo(fStrToFloat(edtPerGru.Text), -2);
        Post;
      End;

      If RoundTo(fRetTotPerGru, -2) = 100 Then
      Begin
        blnMudarFoco := False;
        pSetFocus(edtCodFor);
        Exit;
      End;

    End;

    If Result Then
      pLimpaDadosDet;

  End;

End;

function TfrmCadMetasGalonagem.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    blnMudarFoco := True;

    If (Sender = mskDtaAtual) Then
      Result := fValidaMesAno

    Else If Sender = edtCodVen Then
      Result := fValidaVendedor

    Else If Sender = edtCodFor Then
      Result := fValidaFornecedor(blnBuscaPorChave)

    Else If Sender = edtTotGal Then
      Result := fValidaTotalFornecedor

    Else If (Sender = mskLinhaGrupo) Then
      Result := fValidaGrupo(blnBuscaPorChave)

    Else If (Sender = edtPerGru) Then
      Result := fValidaPercentual

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadMetasGalonagem.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;  
  if fPesqOperador(Self, edtCodVen, edtNomVen, nil, Key, arrSel,True, False, False, False, True) then  
  Begin
    fValidaCampos(edtCodVen, True);
  End;

end;

procedure TfrmCadMetasGalonagem.FormShow(Sender: TObject);
begin
  inherited;
  pAbreCadFor;
  pAbreCadGru;

  mskDtaAtual.Text := FormatDateTime('mm/yyyy', VS_Date);
  fValidaCampos(mskDtaAtual);
  pSetFocus(edtCodVen);

  blnLiberado := fVerificaAcessoSistema('METGAL');

  If Not blnLiberado Then
    shpLiberado.Brush.Color  := clRed
  Else
    shpLiberado.Brush.Color  := clGreen;
end;

procedure TfrmCadMetasGalonagem.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
    fValidaCampos(edtCodFor, True);
end;

Function TfrmCadMetasGalonagem.fValidaTotalGrupo: Boolean;
Begin
  If (RoundTo(fRetTotPerGru, -2) <> 100) Then
  Begin
    fMensagem('', 'A Soma dos grupos deve ser igual a 100%!', ['&Ok']);
    Result := False;
  End

  Else Result := True;
End;

Procedure TfrmCadMetasGalonagem.pIniciaConsulta;
Begin
  pFechaConsulta;
  
  pnlPeriodo.Enabled := True;

  edtCodVen.Clear;
  edtNomVen.Clear;
  pSetFocus(edtCodVen);

End;

Function TfrmCadMetasGalonagem.fValidaGrupos: Boolean;
Begin
  Result := False;

  If Not cdsForGer.Active Then
    Exit;

  If Not cdsForDet.Active Then
    Exit;

  Result := True;

  With cdsForGer Do
  Begin
   DisableControls;
   cdsForDet.DisableControls;

   First;
   While Not Eof Do
   Begin

     If Not fValidaTotalGrupo Then
     Begin
       Result := False;
       Break;
     End;  

     Next;
   End;

   EnableControls;
   cdsForDet.EnableControls;

   If Not Result Then
     pSetFocus(mskLinhaGrupo);

  End;
End;

Function TfrmCadMetasGalonagem.fGravaMetas(blnConfirma: Boolean = True): Boolean;
  Var
    intNroErr: Integer;
Begin
  Result := False;
  
  If Not fValidaGrupos Then
    Exit;

  If blnConfirma Then
  Begin
    If fMensagem('','Confirma a gravação das metas?',['&Sim','&Não']) = 2 Then
      Exit;
  End;

  Try

    fStartTransaction;

    intNroErr := cdsForGer.ApplyUpdates(-1);

    If (intNroErr = 0) Then
      intNroErr := cdsForDet.ApplyUpdates(-1);

    If intNroErr = 0 Then
    Begin
      fCommit;
      Result := True;

      If blnConfirma Then
      Begin
        pMensagemOk('Metas gravadas com sucesso!');
        pIniciaConsulta;
      End;
        
    End Else
      fRollBack;

  Except
    On E : Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[btnConfirmarClick (Metas)]');
    End;
  End;

End;

procedure TfrmCadMetasGalonagem.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  fGravaMetas;

end;

procedure TfrmCadMetasGalonagem.pAtualizaTotPer;
Begin
  edtTotPer.Text := FormatFloat('#,##0.00', fRetTotPerGru);
End;

function TfrmCadMetasGalonagem.fRetTotGal: Double;
Begin
  If (Not cdsForGer.Active) Or (TAggregateField(cdsForGer.FieldByName('TOT_TOTGAL')).Value = Null) Then
    Result := 0
  Else
    Result := TAggregateField(cdsForGer.FieldByName('TOT_TOTGAL')).Value;
End;

procedure TfrmCadMetasGalonagem.pAtualizaTotGal;
Begin
  edtGalGer.Text := FormatFloat('#,##0.00', fRetTotGal);
End;

procedure TfrmCadMetasGalonagem.cdsForDetAfterScroll(DataSet: TDataSet);
begin
  inherited;

  pAtualizaTotPer;
end;

procedure TfrmCadMetasGalonagem.cdsForDetAfterPost(DataSet: TDataSet);
begin
  inherited;

  pAtualizaTotPer;
end;

procedure TfrmCadMetasGalonagem.cdsForGerAfterScroll(DataSet: TDataSet);
begin
  inherited;

  pSetaFiltro;

  pAtualizaTotGal;
end;

procedure TfrmCadMetasGalonagem.pSetaFiltro;
Begin
  cdsForDet.Filter   := 'DET_SEQGER = ' + QuotedStr(cdsForGer.FieldByName('AUTOINCREM').AsString);
  cdsForDet.Filtered := True;

  pLimpaDadosDet(False);
End;

procedure TfrmCadMetasGalonagem.btnSairClick(Sender: TObject);
begin
//  inherited;

  If Not cdsForGer.Active Then
    Close;

  pIniciaConsulta;

end;

procedure TfrmCadMetasGalonagem.cdsForGerBeforePost(DataSet: TDataSet);
begin
  inherited;

  pAtualizaTotGal;
end;


procedure TfrmCadMetasGalonagem.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrGrupos: TConsultasArray;
begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, Nil, Key, arrGrupos) Then
  Begin
    fValidaCampos(mskLinhaGrupo, True);
  End;
end;

procedure TfrmCadMetasGalonagem.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaAtual);
end;

procedure TfrmCadMetasGalonagem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirmar.Click;
  End;

end;

procedure TfrmCadMetasGalonagem.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Key = '-' Then
    Key := #0;

end;

procedure TfrmCadMetasGalonagem.cxgGruposDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: Begin
                 pCarregaRegistroGrupo;
                 pSetFocus(edtPerGru);
               End;
  End;

end;

procedure TfrmCadMetasGalonagem.cxgFornecedoresDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: Begin
                 pCarregaRegistroFornecedor;
                 pSetFocus(edtTotGal);
               End;
  End;

end;

procedure TfrmCadMetasGalonagem.btnCopMetClick(Sender: TObject);
begin
  inherited;

  If fGravaMetas(False) Then
    pCopiaMetas;

end;

procedure TfrmCadMetasGalonagem.pCopiaMetas;
  Var
    frmCadMetasGalonCopia: TfrmCadMetasGalonCopia;
Begin
  pCriarFormularios(TfrmCadMetasGalonCopia, frmCadMetasGalonCopia);

  If Assigned(frmCadMetasGalonCopia) Then
  Begin
    With frmCadMetasGalonCopia Do
    Begin
      strVenOri := edtCodVen.Text;
      strDtaOri := mskDtaAtual.Text;
      blnLibera := blnLiberado;
      ShowModal;
    End;
    FreeAndNil(frmCadMetasGalonCopia);
  End;
End;

end.
