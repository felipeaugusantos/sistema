{***************************}
{* qryConIte -> CADITE     *}
{************************JB*}

unit untRelacSimilaridade;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  Grids, DBGridCitel, DBGrids, EditFocus, {Qt,} StrUtils, Menus, DB, untCamGer, untBonGer,
    Uni, AppEvnts, UniClientDataSet, UniDataSetProvider,
  BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox;

type
  TfrmRelacSimilaridade = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodSim: TEditFocus;
    Label2: TLabel;
    edtCodIte: TEditFocus;
    dbgItens: TDBGridCitel;
    pnlBotoesSim: TPanel;
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    btnConfirma: TBitBtnLocked;
    btnDeletar: TBitBtnLocked;
    btnPesquisa: TBitBtnLocked;
    btnCancelarEntrada: TBitBtnLocked;
    cxlProPri: TcxLookupComboBox;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDeletarClick(Sender: TObject);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarEntradaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    objCamGer: TCamGer;
    objBonGer: TBonGer;
    qryConIte: TUniQuery;

    procedure pCarregaItem;

    procedure pCarregaItensSimilares(strCodSim: String);
    procedure pDeletaTemporaria;

    procedure pConfirmaSimilaridades;
    procedure pAdicionaItem;
    function fMarcadoTodosParaDeletar: Boolean;

  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmRelacSimilaridade: TfrmRelacSimilaridade;

implementation

uses untfuncoesSimples, untModulo, untPesqAux, untPai, untConsultas,
  untTypesSistema;

{$R *.dfm}

{ TfrmRelacSimilaridade }

function TfrmRelacSimilaridade.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodIte) Then
    Begin

      If fEmptyStr(edtCodIte.Text) Then
      Begin
//        blnMudarFoco := False;
//        pSetFocus(dbgItens);
      End
      Else
      Begin
        pCarregaItem;
        If qryConIte.FieldByName('ITE_CODITE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
          edtCodIte.Clear;
          Result := False;
        End
        Else If Not SameText(qryConIte.FieldByName('ITE_ITEATI').AsString,'S') Then
        Begin

          If fMensagem('', 'Esse item esta inativo, utiliza-lo mesmo assim?', ['','']) = 1 Then
          Begin
            pAdicionaItem;
            edtCodIte.Clear;
            Result := False;
          End
          Else
          Begin
            edtCodIte.Clear;
            Result := False;
          End;

        End
        Else
        Begin
          pAdicionaItem;
          edtCodIte.Clear;
          Result := False;
        End;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelacSimilaridade.pAdicionaItem;
  Var
    blnNovaSimilaridade: Boolean;
    blnInsereItem: Boolean;
    intConFor : Integer;
    BookMark  : TBookmark;
    strCodCmg1: String;
    strCodCmg2: String;
    strCodBmg1: String;
    strCodBmg2: String;
    blnResult : Boolean;
    qryGenSim : TUniQuery;

begin
  qryGenSim := fCriaQuery(Self);

  qryConIte.First;

  while not qryConIte.Eof do
  Begin
    blnNovaSimilaridade := True;
    blnResult           := False;

    If (cdsConsulta.Active)           And
       (cdsConsulta.RecordCount <= 0) Then
    Begin
      If (Not qryConIte.FieldByName('ITE_CODSIM').IsNull) Then
      Begin
        pCarregaItensSimilares(qryConIte.FieldByName('ITE_CODSIM').AsString);
        edtCodIte.Clear;
        Exit;
      //  blnNovaSimilaridade := False;
      End;
    End;

    If blnNovaSimilaridade Then
    Begin

      With cdsConsulta Do
      Begin
        DisableControls;
        blnInsereItem := Not Locate('ITE_CODITE', qryConIte.FieldByName('ITE_CODITE').AsString, []);
        EnableControls;
      End;

      If blnInsereItem Then
      Begin

        If (Not qryConIte.FieldByName('ITE_CODSIM').IsNull) Then
          fMensagem('ATENÇÃO!', 'Esse item já está cadastrado em outra Similaridade!', ['&O k'])
        Else
        Begin

          If (fCfgSis('SIMCAM', varBoolean)) Then
          Begin

            If (Not fEmptyStr(edtCodSim.Text)) Then
            Begin
              For intConFor := 0 To High(objCamGer.objCamDet.arrCampanhaDet) Do
              Begin

               If (objCamGer.objCamDet.arrCampanhaDet[intConFor].strCodIte = edtCodIte.Text) And (Not fEmptyStr(edtCodSim.Text)) Then
                 Begin
                   If objCamGer.objCamDet.fVerificaProdutoCampanha(objCamGer.objCamDet.arrCampanhaDet[intConFor].strCodCmg,
                                                                   edtCodIte.Text) <> '-1' Then
                   Begin
                     fMensagem('', 'Não é permitido inserir na mesma similaridade produtos que' + #13 +
                                   'já fazem parte de uma campanha. Código da campanha: ' + objCamGer.objCamDet.arrCampanhaDet[intConFor].strCodCmg, ['&Ok']);
                     Exit;
                   End;
                 End;

              End;
            End;

            If cdsConsulta.RecordCount > 0 Then
            Begin
              For intConFor := 0 To High(objCamGer.objCamDet.arrCampanhaDet) Do
              Begin

                BookMark := cdsConsulta.GetBookmark;

                With cdsConsulta Do
                Begin

                  DisableControls;

                  First;

                  strCodCmg1 := '0';
                  strCodCmg2 := '0';

                  While Not Eof Do
                  Begin

                    strCodCmg1 := objCamGer.objCamDet.fVerificaProdutoCampanha(objCamGer.objCamDet.arrCampanhaDet[intConFor].strCodCmg, edtCodIte.Text);
                    strCodCmg2 := objCamGer.objCamDet.fVerificaProdutoCampanha(objCamGer.objCamDet.arrCampanhaDet[intConFor].strCodCmg, FieldByName('ITE_CODITE').AsString);

                    If (strCodCmg1 <> '-1') And (strCodCmg2 <> '-1') Then
                      If strCodCmg1 = strCodCmg2 Then
                      Begin
                        fMensagem('', 'Não é permitido inserir na mesma similaridade produtos que' + #13 +
                                   'já fazem parte de uma campanha. Código da campanha: ' + objCamGer.objCamDet.arrCampanhaDet[intConFor].strCodCmg, ['&Ok']);
                        Exit;
                      End;

                    Next;

                  End;

                  EnableControls;

                End;

                cdsConsulta.GotoBookmark(BookMark);
                cdsConsulta.FreeBookmark(BookMark);

              End;
            End;

            If Not blnResult Then
            Begin

              For intConFor := 0 To High(objBonGer.objBonDet.arrBonusDet) Do
              Begin

                 If (objBonGer.objBonDet.arrBonusDet[intConFor].strCodIte = edtCodIte.Text) And (Not fEmptyStr(edtCodSim.Text)) Then
                 Begin
                   If objBonGer.objBonDet.fVerificaProdutoBonus(objBonGer.objBonDet.arrBonusDet[intConFor].strCodBmg,
                                                                   edtCodIte.Text) <> '-1' Then
                   Begin
                     fMensagem('', 'Não é permitido inserir na mesma similaridade produtos que' + #13 +
                                   'fazem parte de um mesmo bônus. Código do bônus: ' + objBonGer.objBonDet.arrBonusDet[intConFor].strCodBmg, ['&Ok']);
                     Exit;
                   End;
                 End;

              End;

              For intConFor := 0 To High(objBonGer.objBonDet.arrBonusDet) Do
              Begin

                 BookMark := cdsConsulta.GetBookmark;

                 With cdsConsulta Do
                 Begin

                   DisableControls;

                   First;

                   strCodCmg1 := '0';
                   strCodCmg2 := '0';

                   While Not Eof Do
                   Begin

                     strCodBmg1 := objBonGer.objBonDet.fVerificaProdutoBonus(objBonGer.objBonDet.arrBonusDet[intConFor].strCodBmg, edtCodIte.Text);
                     strCodBmg2 := objBonGer.objBonDet.fVerificaProdutoBonus(objBonGer.objBonDet.arrBonusDet[intConFor].strCodBmg, FieldByName('ITE_CODITE').AsString);

                     If (strCodBmg1 <> '-1') And (strCodBmg2 <> '-1') Then
                       If strCodBmg1 = strCodBmg2 Then
                       Begin
                         fMensagem('', 'Não é permitido inserir na mesma similaridade produtos que' + #13 +
                                     'fazem parte de um mesmo bônus. Código do bônus: ' + objBonGer.objBonDet.arrBonusDet[intConFor].strCodBmg, ['&Ok']);
                         Exit;
                       End;

                     Next;

                   End;

                   EnableControls;

                 End;

                 cdsConsulta.GotoBookmark(BookMark);
                 cdsConsulta.FreeBookmark(BookMark);

              End;

            End;

          End;

          With cdsConsulta Do
          Begin
            pPesquisaCadIte(qryConIte, qryGenSim, qryConIte.FieldByName('ITE_CODITE').AsString, '', False, False, False);

            Insert;
            FieldByName('ITE_CODITE').AsString := qryGenSim.FieldByName('ITE_CODITE').AsString;
            FieldByName('ITE_DESITE').AsString := qryGenSim.FieldByName('ITE_DESITE').AsString;
            FieldByName('DESITE').AsString     := Concat(qryGenSim.FieldByName('ITE_CODITE').AsString, '-', qryGenSim.FieldByName('ITE_DESITE').AsString);
            FieldByName('ITE_REFERE').AsString := qryGenSim.FieldByName('ITE_REFERE').AsString;
            FieldByName('UNI_SIGUNI').AsString := fRetSiglaUni(qryGenSim.FieldByName('ITE_CODUNI').AsString);
            FieldByName('ITE_CODSIM').AsString := qryGenSim.FieldByName('ITE_CODSIM').AsString;
            FieldByName('MAR_DESMAR').AsString := qryGenSim.FieldByName('MAR_DESMAR').AsString;
            FieldByName('ITE_CODFAB').AsString := qryGenSim.FieldByName('ITE_CODFAB').AsString;
            FieldByName('ITE_DELETA').AsString := 'N';
            Post;
          End;

        End;

      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'O item ' +qryConIte.FieldByName('ITE_CODITE').AsString +' já esta cadastrado!', ['&O k']);
      End;

      qryConIte.Next;

    End;

  End;

  FreeAndNil(qryGenSim);
end;

procedure TfrmRelacSimilaridade.pCarregaItem;
  Var
    blnBuscaCodBar: Boolean;
begin

  blnBuscaCodBar := True;

  If (Length(Trim(edtCodIte.Text)) <= fTamCodIte) Then
  Begin
    edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);
    blnBuscaCodBar := False;
  End;

  pPesquisaCadIte(qryConIte, qryConIte, edtCodIte.Text, '', blnBuscaCodBar, False, False);
  With qryConIte Do
  Begin

    If blnBuscaCodBar Then
      edtCodIte.Text := qryConIte.FieldByName('ITE_CODITE').AsString;

    If (fEmptyStr(edtCodSim.Text))                   And
       ((Not cdsConsulta.Active) Or (cdsConsulta.RecordCount <= 0)) Then
    Begin
      edtCodSim.Text := qryConIte.FieldByName('ITE_CODSIM').AsString;
    End;

  End;

end;

procedure TfrmRelacSimilaridade.pDeletaTemporaria;
begin
  If cdsConsulta.Active Then
    cdsConsulta.EmptyDataSet;
end;

procedure TfrmRelacSimilaridade.pEscapePressed;
begin
  If (ActiveControl.Parent = pnlCabecalho) Then
  Begin
    If (cdsConsulta.Active) And
       (cdsConsulta.RecordCount > 0) Then
    Begin
      If fMensagem('', 'Abandona Itens?', ['&Sim', '&Não']) = 1 Then
      Begin

        pDeletaTemporaria;
        edtCodIte.Clear;
        edtCodSim.Clear;

      End;
    End
    Else
    Begin
      inherited;
    End;
  End;
end;

procedure TfrmRelacSimilaridade.pCarregaItensSimilares(strCodSim: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ITE_CODITE, ';
  strSQL := strSQL + '  CONCAT(ITE_CODITE, "-", ITE_DESITE) AS DESITE,';
  strSQL := strSQL + '  ITE_DESITE, ';
  strSQL := strSQL + '  ITE_REFERE, ';
  strSQL := strSQL + '  UNI_SIGUNI, ';
  strSQL := strSQL + '  ITE_PRISIM, ';
  strSQL := strSQL + '  ITE_CODFAB, ';
  strSQL := strSQL + '  ' + QuotedStr(fstrEspaco(strCodSim, 6)) + ' AS ITE_CODSIM, ';
  strSQL := strSQL + '  MAR_DESMAR, ';
  strSQL := strSQL + '  "N" AS ITE_DELETA '; //Deleta (Sim / Nao)
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE ';
  strSQL := strSQL + '  LEFT JOIN CADMAR ON ITE_CODMAR = MAR_CODMAR ';
  strSQL := strSQL + '  LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODSIM = :CODSIM ';

  With qryConsulta Do
  Begin
    Close;
    cdsConsulta.Close;

    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODSIM').AsString := strCodSim;

    Open;
    pSetaClient(qryConsulta);

    cdsConsulta.Open;
    pSetaClient(cdsConsulta);

    If cdsConsulta.Locate('ITE_PRISIM', 'S', []) Then
      cxlProPri.Text := cdsConsulta.FieldByName('DESITE').AsString;
  End;

end;

procedure TfrmRelacSimilaridade.FormCreate(Sender: TObject);
  Const
    sSQL = 'SELECT CADITE.*, CADMAR.MAR_DESMAR ' +
             'FROM CADITE LEFT JOIN CADMAR ' +
             '  ON CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR WHERE FALSE';
begin
  inherited;

  qryConsulta.Connection := frmModulo.GetCurrentConnection;

  qryConIte := fCriarQuery(sSQL, Self);
  pSetaQueryCadIte(qryConIte);

  objCamGer := TCamGer.Create(Self);
  objCamGer.objCamDet.pCarregaCamDet('', 0, True);
  
  objBonGer := TBonGer.Create(Self);
  objBonGer.objBonDet.pCarregaBonDet('', 0);

  pCarregaItensSimilares('FALSE');
end;

procedure TfrmRelacSimilaridade.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDeletaTemporaria;
end;

procedure TfrmRelacSimilaridade.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (cdsConsulta.Active)          And
     (cdsConsulta.RecordCount > 0) Then
  Begin

   If (Not cdsConsulta.Locate('ITE_CODITE', LeftStr(cxlProPri.Text, fTamCodIte), [])) Or
       (cdsConsulta.FieldByName('ITE_DELETA').AsString = 'S') Then
    Begin
      cxlProPri.Text := '';
      If Not fMarcadoTodosParaDeletar Then
      Begin
        pMensagemOk('Informe qual o principal produto dos similares!');
        Exit;
      End;
    End;

    If fMensagem('', 'Confirma Itens?', ['&Sim', '&Não']) = 1 Then
    Begin
      pConfirmaSimilaridades;
      pDeletaTemporaria;
      pSetFocus(edtCodIte);
      edtCodIte.Clear;
      edtCodSim.Clear;
    End;

  End;

end;

procedure TfrmRelacSimilaridade.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Delete) Then
  Begin
    btnDeletar.Click;
  End
  Else If (Key = VK_Escape) Then
  Begin
    pSetFocus(edtCodIte);
  End;
end;

procedure TfrmRelacSimilaridade.btnDeletarClick(Sender: TObject);
begin
  inherited;

  Try

    If (cdsConsulta.Active)           And
       (cdsConsulta.RecordCount <= 0) Then
    Begin
      pSetFocus(edtCodIte);
      Exit;
    End;

    With cdsConsulta Do
    Begin
      Edit;

      If FieldByName('ITE_DELETA').AsString = 'S' Then
        FieldByName('ITE_DELETA').AsString := 'N'
      Else
      Begin
        FieldByName('ITE_DELETA').AsString := 'S';

        If SameText(LeftStr(cxlProPri.Text, fTamCodIte), FieldByName('ITE_CODITE').AsString) Then
          cxlProPri.Text := '';
      End;

      Post;
    End;

    pSetFocus(dbgItens);

  Finally

  End;

end;

procedure TfrmRelacSimilaridade.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  With cdsConsulta Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
    If Not Active Then
      Exit;

    If FieldByName('ITE_DELETA').AsString = 'S' Then
    Begin
      dbgItens.Canvas.Font.Color := clBlue;
    End;
    {Else
    Begin
      dbgItens.Canvas.Font.Color := clBlack;
    End;}

  End;

  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmRelacSimilaridade.pConfirmaSimilaridades;
  Var
    strCodSim: String;
    strSQL: String;
    strSimilares: String;
    strDeletados: String;
    qryCfgSis: TUniQuery;
    qryGenIte: TUniQuery;
begin
  Try
    qryCfgSis := fCriaQuery(Self);
    qryGenIte := fCriaQuery(Self);

    strSimilares := '';
    strDeletados := '';

    If fEmptyStr(edtCodSim.Text) Then
    Begin

      Try

        With qryCfgSis Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT                     ');
          SQL.Add('  SIS_VALCFG               ');
          SQL.Add('FROM                       ');
          SQL.Add('  CFGSIS                   ');
          SQL.Add('WHERE                      ');
          SQL.Add('  SIS_CODEMP = :CODEMP AND ');
          SQL.Add('  SIS_CODCFG = :CODCFG     ');
          SQL.Add('FOR UPDATE                 ');

          ParamByName('CODEMP').Value := VS_strCodEmp;
          ParamByName('CODCFG').Value := 'CFG_CODSIM';
          Open;

          If Not fEmptyStr(FieldByName('SIS_VALCFG').AsString) Then
            strCodSim := fStrZero(FieldByName('SIS_VALCFG').AsString, 6)
          Else
            strCodSim := fStrZero('1', 6);

          fAtuCfgSis('CODSIM', IntToStr(StrToInt(strCodSim)+1));

        End;

      Except
        On E: Exception Do
        Begin
          Raise Exception.Create('Não consegui pegar o proximo sequencial de CODSIM em CFGSIS. Tente novamente!');
        End;
      End;

    End
    Else
      strCodSim := edtCodSim.Text;           

    With cdsConsulta Do
    Begin

      First;

      While Not Eof Do
      Begin

        If FieldByName('ITE_DELETA').AsString = 'S' Then
        Begin
          strDeletados := strDeletados + FieldByName('ITE_CODITE').AsString + ',';
        End
        Else
        Begin
          strSimilares := strSimilares + FieldByName('ITE_CODITE').AsString + ',';
        End;
        Next;

      End;

    End;

    If (Not fEmptyStr(strSimilares)) Then
    Begin

      If RightStr(strSimilares, 1) = ',' Then
        strSimilares := Copy(strSimilares, 1, Length(strSimilares)-1);

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  CADITE ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  ITE_CODSIM = :CODSIM, ';
      strSQL := strSQL + '  ITE_PRISIM = IF(ITE_CODITE = :PRISIM, "S", "N") ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  ITE_CODITE IN (' + strSimilares + ') ';

      With qryGenIte Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODSIM').AsString := strCodSim;
        ParamByName('PRISIM').AsString := LeftStr(cxlProPri.Text, fTamCodIte);
        ExecSQL;
        Close;

      End;

    End;

    If (Not fEmptyStr(strDeletados)) Then
    Begin

      If RightStr(strDeletados, 1) = ',' Then
        strDeletados := Copy(strDeletados, 1, Length(strDeletados)-1);

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  CADITE ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  ITE_CODSIM = NULL ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  ITE_CODITE IN (' + strDeletados + ') ';

      With qryGenIte Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;

      End;
      
    End;

  Finally
    FreeAndNil(qryCfgSis);
    FreeAndNil(qryGenIte);
  End;

end;

procedure TfrmRelacSimilaridade.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If (ActiveControl.Parent <> Nil) And (ActiveControl.Parent Is TcxLookupComboBox) Then
                 SelectNext(ActiveControl.Parent, True, True);

    VK_F10: btnConfirma.Click;
    VK_F5 : btnPesquisa.Click;
  End;
end;

procedure TfrmRelacSimilaridade.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodIte);
end;

procedure TfrmRelacSimilaridade.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodIte, nil, qryConIte, Key, arrSel, False, nil, 'Consulta de Itens', '1') Then
  Begin
    If (qryConIte.RecordCount = 1) Then
      pCarregaItem;

    pAdicionaItem;
    edtCodIte.Clear;
  End;
end;

function TfrmRelacSimilaridade.fMarcadoTodosParaDeletar: Boolean;
  var intRecNo: Integer;
begin
  intRecNo := cdsConsulta.RecNo;
  cdsConsulta.First;
  Result := Not(cdsConsulta.Locate('ITE_DELETA', 'N', []));
  cdsConsulta.RecNo := intRecNo;
end;

procedure TfrmRelacSimilaridade.btnCancelarEntradaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRelacSimilaridade.btnPesquisaClick(Sender: TObject);
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
Begin
  inherited;

  chrKey := '?';

  If fPesqItem(conIteSimilar, Self, edtCodIte, nil, qryConIte, chrKey, arrSel, False, nil, 'Consulta de Itens', '1')  Then
  Begin
    pDeletaTemporaria;
    edtCodSim.Clear;

    pCarregaItem;
    pSetFocus(edtCodIte);
  End;

End;

End.


