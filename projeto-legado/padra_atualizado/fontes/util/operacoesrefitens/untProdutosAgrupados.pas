{***********************}
{* qryConIte -> CADITE *}
{********************JB*}

unit untProdutosAgrupados;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  Grids, DBGridCitel, DBGrids, EditFocus, {Qt,} StrUtils, Menus, DB,
  Uni,  AppEvnts, UniClientDataSet,
  UniDataSetProvider, BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider,
  frxClass, frxExportCSVTestabilidade, Datasnap.DBClient, untGravando,
  cxProgressBar;

type
  TfrmProdutosAgrupados = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodAgr: TEditFocus;
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
    btnTrocaPai: TBitBtnLocked;
    btnPesquisa: TBitBtnLocked;
    btnCancelarEntrada: TBitBtnLocked;
    Shape3: TShape;
    Label8: TLabel;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnAddLinhaGrupo: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);  procedure btnConfirmaClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDeletarClick(Sender: TObject);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarEntradaClick(Sender: TObject);
    procedure dbgItensDblClick(Sender: TObject);
    procedure btnTrocaPaiClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnAddLinhaGrupoClick(Sender: TObject);
  private
    { Private declarations }
    qryConIte: TUniQuery;
    lstProdImportLinhaGrupo: TStringList;
    FfrmGravandoCorrente: TFrmGravando;
    FblnMostrarMensagem: Boolean;

    function fVerificaAgrupamentos(strCodIte: string):string;
    procedure pCarregaItem;

    procedure pCarregaItensAgrupados(strCodAgr: String);
    procedure pDeletaTemporaria;

    procedure pConfirmaAgrupamentos;
    procedure pAdicionaItem;

    procedure pTrocaPai;

    procedure pVerificaSeEhPai;

    procedure pMarcarTodos(blnMarcar: Boolean);

    function fImportarProdutosListaLinhaGrupo: Boolean;

    function fImportarProdutosListaLinhaGrupoPrg(prbProgresso: TcxProgressBar):Boolean;

  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }

  end;

var
  frmProdutosAgrupados: TfrmProdutosAgrupados;

implementation

uses untfuncoesSimples, untModulo, untPesqAux, untPai, untConsultas,
  untProdutosAgrupadosItens, untTypesSistema, untProdAgrpAddLinhaGrupo;

{$R *.dfm}

{ TfrmProdutosAgrupados }

function TfrmProdutosAgrupados.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodIte) Then
    Begin

      If fEmptyStr(edtCodIte.Text) Then
      Begin
        blnMudarFoco := False;
        pSetFocus(dbgItens);
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

procedure TfrmProdutosAgrupados.pAdicionaItem;
  Var
    blnNovoAgrupamento: Boolean;
    blnInsereItem     : Boolean;
begin
  blnNovoAgrupamento  := True;

  If (cdsConsulta.Active) And (cdsConsulta.RecordCount <= 0) Then
  Begin
    edtCodAgr.Text:=fVerificaAgrupamentos(qryConIte.FieldByName('ITE_CODITE').AsString);

    If Not fEmptyStr(edtCodAgr.Text) Then
    Begin
      pCarregaItensAgrupados(edtCodAgr.Text);
      edtCodIte.Clear;
      blnNovoAgrupamento := False;
    End;
  End;

  If blnNovoAgrupamento Then
  Begin

    With cdsConsulta Do
    Begin
      DisableControls;
      blnInsereItem := Not Locate('AGR_CODITE', qryConIte.FieldByName('ITE_CODITE').AsString, []);
      EnableControls;
    End;

    If blnInsereItem Then
    Begin
      With cdsConsulta Do
      Begin
        Insert;
        FieldByName('ITE_DESITE').AsString := qryConIte.FieldByName('ITE_DESITE').AsString;
        FieldByName('ITE_REFERE').AsString := qryConIte.FieldByName('ITE_REFERE').AsString;
        FieldByName('ITE_CODUNI').AsString := qryConIte.FieldByName('ITE_CODUNI').AsString;
        FieldByName('AGR_CODITE').AsString := qryConIte.FieldByName('ITE_CODITE').AsString;
        FieldByName('AGR_CODAGR').AsString := '';
        FieldByName('AGR_ITEPAI').AsString := 'N';
        Post;
      End;
    End
    Else
    Begin
      If FblnMostrarMensagem Then
        fMensagem('ATENÇÃO!', 'Esse item já esta cadastrado!', ['&O k']);
    End;

  End;
end;

procedure TfrmProdutosAgrupados.pCarregaItem;
  Var
    blnBuscaCodBar: Boolean;
begin
  blnBuscaCodBar := True;

  If (Length(Trim(edtCodIte.Text)) <= fTamCodIte) Then
  Begin
    edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);
    blnBuscaCodBar := False;
  End;

  pPesquisaCadIte(qryConIte, qryConIte, edtCodIte.Text, '', blnBuscaCodBar);

  With qryConIte Do
  Begin
    If blnBuscaCodBar Then
      edtCodIte.Text := qryConIte.FieldByName('ITE_CODITE').AsString;

    If (fEmptyStr(edtCodAgr.Text)) And (cdsConsulta.RecordCount <= 0) Then
    Begin
      edtCodAgr.Text := fVerificaAgrupamentos(edtCodIte.Text);
    End;
  End;

end;

procedure TfrmProdutosAgrupados.pDeletaTemporaria;
begin
  If cdsConsulta.Active Then
    cdsConsulta.EmptyDataSet;

  edtCodIte.Clear;
  edtCodAgr.Clear;

  pSetFocus(edtCodIte);
end;

procedure TfrmProdutosAgrupados.pEscapePressed;
begin
  If (ActiveControl.Parent = pnlCabecalho) Then
  Begin
    If (cdsConsulta.Active) And
       (cdsConsulta.RecordCount > 0) Then
    Begin
      If fMensagem('', 'Abandona Itens?', ['&Sim', '&Não']) = 1 Then
      Begin
        pDeletaTemporaria;
      End;
    End
    Else
    Begin
      inherited;
    End;
  End;
end;

procedure TfrmProdutosAgrupados.pMarcarTodos(blnMarcar: Boolean);
begin
  If (cdsConsulta.Active) And(cdsConsulta.RecordCount <= 0) Then
  Begin
    pSetFocus(edtCodIte);
    Exit;
  End;
  Try
    With cdsConsulta Do
    Begin
      DisableControls;
      First;
      While Not Eof Do
      Begin
        Edit;
        If blnMarcar Then
          FieldByName('ITE_DELETA').AsString := 'S'
        Else
          FieldByName('ITE_DELETA').AsString := 'N';
        Post;
        Next;
      End;
    End;
    Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmProdutosAgrupados.pMarcarTodos]');
    End;
  End;
  cdsConsulta.EnableControls;
  pSetFocus(dbgItens);

End;

procedure TfrmProdutosAgrupados.pCarregaItensAgrupados(strCodAgr: String);
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + ' ITE_DESITE, ';
  strSQL := strSQL + ' ITE_REFERE, ';
  strSQL := strSQL + ' ITE_CODUNI, ';
  strSQL := strSQL + ' AGR_CODITE, ';
  strSQL := strSQL + ' AGR_CODAGR, ';
  strSQL := strSQL + ' AGR_ITEPAI, ';
  strSQL := strSQL + ' "N" AS ITE_DELETA ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE ';
  strSQL := strSQL + '  INNER JOIN CADAGR ON (AGR_CODITE=ITE_CODITE) ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AGR_CODAGR = :CODAGR ';
  strSQL := strSQL + 'ORDER BY AGR_ITEPAI DESC, ITE_REFERE';

  With qryConsulta Do
  Begin
    Close;
    cdsConsulta.Close;

    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODAGR').AsString := strCodAgr;
    Open;
    pSetaClient(qryConsulta);

    cdsConsulta.Open;
    pSetaClient(cdsConsulta);
  End;

end;

procedure TfrmProdutosAgrupados.FormCreate(Sender: TObject);
begin
  inherited;

  qryConIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  pSetaQueryCadIte(qryConIte);

  FblnMostrarMensagem := True;

  qryConsulta.Connection := frmModulo.GetCurrentConnection;

  pCarregaItensAgrupados('FALSE');
end;

procedure TfrmProdutosAgrupados.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  pDeletaTemporaria;
end;

procedure TfrmProdutosAgrupados.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (cdsConsulta.Active) And (cdsConsulta.RecordCount > 0) Then
  Begin
    If Not cdsConsulta.Locate('AGR_ITEPAI', 'S', []) Then
    Begin
      pMensagemOk('Marque pelo menos um item como "Pai"!');
      Exit;
    End;

    If Not cdsConsulta.Locate('AGR_ITEPAI', 'N', []) Then
    Begin
      pMensagemOk('Marque pelo menos um item como "Filho"!');
      Exit;
    End;

    pVerificaSeEhPai;

    If fMensagem('', 'Confirma Itens?', ['&Sim', '&Não']) = 1 Then
    Begin
      pConfirmaAgrupamentos;
      pDeletaTemporaria;
      pSetFocus(edtCodIte);
    End;

  End;

end;

procedure TfrmProdutosAgrupados.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Delete) Then
  Begin
    btnDeletar.Click;
  End
  Else If (Key = VK_F6) Then
  Begin
    btnMarcaTodos.Click;
  End
  Else If (Key = VK_F7) Then
  Begin
    btnDesmarcaTodos.Click;
  End
  Else If (Key = VK_Escape) Then
  Begin
    pSetFocus(edtCodIte);
  End
  Else If (Key = VK_RETURN) Then
  Begin
    btnTrocaPai.Click;
  End;

end;

procedure TfrmProdutosAgrupados.btnDeletarClick(Sender: TObject);
begin
  inherited;

  If (cdsConsulta.Active) And(cdsConsulta.RecordCount <= 0) Then
  Begin
    pSetFocus(edtCodIte);
    Exit;
  End;

  With cdsConsulta Do
  Begin
    Edit;
    FieldByName('ITE_DELETA').AsString
         :=IIF(FieldByName('ITE_DELETA').AsString = 'S','N','S');
    Post;
  End;

  pSetFocus(dbgItens);
end;

procedure TfrmProdutosAgrupados.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarTodos(False);
end;

procedure TfrmProdutosAgrupados.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarTodos(True);
end;

procedure TfrmProdutosAgrupados.dbgItensDrawColumnCell(Sender: TObject;
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

  End;

  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmProdutosAgrupados.pConfirmaAgrupamentos;
  Var
    strCodAgr: String;
    qryCfgSis: TUniQuery;
    qryGenIte: TUniQuery;

  Const
    sqlINS = 'INSERT INTO CADAGR(AGR_CODAGR, AGR_ITEPAI, AGR_CODITE) VALUES(:AGR_CODAGR, :AGR_ITEPAI, :AGR_CODITE)';
    sqlUPD = 'UPDATE CADAGR SET AGR_ITEPAI=:AGR_ITEPAI WHERE AGR_CODAGR=:AGR_CODAGR AND AGR_CODITE=:AGR_CODITE';
    sqlDEL = 'DELETE FROM CADAGR WHERE AGR_CODAGR=:AGR_CODAGR AND AGR_CODITE=:AGR_CODITE';

  procedure pExecutaUpdate(strQry:string);
  begin
    qryGenIte.Close;
    qryGenIte.SQL.Clear;
    qryGenIte.SQL.Text:=strQry;

    qryGenIte.ParamByName('AGR_CODAGR').AsString:=iif(not fEmptyStr(cdsConsulta.FieldByName('AGR_CODAGR').AsString),
                                                          cdsConsulta.FieldByName('AGR_CODAGR').AsString,
                                                          strCodAgr);
    qryGenIte.ParamByName('AGR_CODITE').AsString:=cdsConsulta.FieldByName('AGR_CODITE').AsString;
    If (strQry=sqlINS) Or (strQry=sqlUPD) Then
      qryGenIte.ParamByName('AGR_ITEPAI').AsString:=cdsConsulta.FieldByName('AGR_ITEPAI').AsString;

    qryGenIte.ExecSQL;
  end;

begin
  Try

    qryCfgSis := fCriaQuery(Self);
    qryGenIte := fCriaQuery(Self);

    pnlInfo.Caption:='Aguarde...Gravando Registros';
    pnlInfo.Refresh;
    pnlBotoesSim.Enabled:=False;

    If fEmptyStr(edtCodAgr.Text) Then
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
          ParamByName('CODCFG').Value := 'CFG_CODAGR';
          Open;

          If Not fEmptyStr(FieldByName('SIS_VALCFG').AsString) Then
            strCodAgr := fStrZero(FieldByName('SIS_VALCFG').AsString, 6)
          Else
            strCodAgr := fStrZero('1', 6);

          fAtuCfgSis('CODAGR', IntToStr(StrToInt(strCodAgr)+1));

        End;

      Except
        On E: Exception Do
        Begin
          Raise Exception.Create('Não consegui pegar o proximo sequencial de CODAGR em CFGSIS. Tente novamente!');
        End;
      End;

    End
    Else
      strCodAgr := edtCodAgr.Text;

    fStartTransaction;
    Try
      With cdsConsulta Do
      Begin
        DisableControls;

        First;

        While Not Eof Do
        Begin

          If FieldByName('AGR_CODAGR').AsString = '' Then
          Begin
            pExecutaUpdate(sqlINS);
          End
          Else
            If FieldByName('ITE_DELETA').AsString = 'S' Then
            Begin
              pExecutaUpdate(sqlDEL);
            End
              Else
              Begin
                pExecutaUpdate(sqlUPD);
              End;

          Next;

        End;

        fCommit;
      End;
    Except
      On e: exception Do
      Begin
        pMensagensErro(E.Message, '');
        fRollBack;
      End;
    End;

  Finally
    pnlInfo.Caption:='';
    pnlBotoesSim.Enabled:=True;
    
    cdsConsulta.EnableControls;
    FreeAndNil(qryCfgSis);
    FreeAndNil(qryGenIte);
  End;

end;

procedure TfrmProdutosAgrupados.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;

  If (Key = VK_F5) Then
  Begin
    btnPesquisa.Click;
  End;

  If (Key = VK_F8) Then
  Begin
    btnAddLinhaGrupo.Click;
  End;
End;

procedure TfrmProdutosAgrupados.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
    intSel: Integer;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodIte, nil, qryConIte, Key, arrSel, False, nil, 'Consulta de Itens', '1') Then
  Begin
    For intSel := 0 to Length(arrSel) -1 Do
    Begin
      edtCodIte.Text := arrSel[intSel].strCodigo;
      fValidaCampos(edtCodIte);
    end;
  End;

end;

function TfrmProdutosAgrupados.fImportarProdutosListaLinhaGrupoPrg(
  prbProgresso: TcxProgressBar): Boolean;
var
  I:Integer;
begin

   { Controle da flag de mostrar mensagem 'este item não está cadastrado'
   para não interromper a importação via linha/grupo  }
  If lstProdImportLinhaGrupo.Count > 0 Then
    FblnMostrarMensagem := False;

  prbProgresso.Position := 0;
  prbProgresso.Properties.Max := lstProdImportLinhaGrupo.Count;

  For I:= 0 To lstProdImportLinhaGrupo.Count-1 Do
  Begin
    edtCodIte.Text := lstProdImportLinhaGrupo[I];
    pCarregaItem;
    If Not cdsConsulta.Locate('AGR_CODITE', qryConIte.FieldByName('ITE_CODITE').AsString, []) Then
      fValidaCampos(edtCodIte, True);

    prbProgresso.Position := prbProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  Result := True;

  FblnMostrarMensagem := True;
end;

function TfrmProdutosAgrupados.fImportarProdutosListaLinhaGrupo: Boolean;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Importando itens...';
  frmGravando.fExecutarAcao := fImportarProdutosListaLinhaGrupoPrg;

  FfrmGravandoCorrente := frmGravando;

  frmGravando.ShowModal;

  Result := frmGravando.blnConfirma;
end;

procedure TfrmProdutosAgrupados.btnAddLinhaGrupoClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmProdAgrpAddLinhaGrupo, frmProdAgrpAddLinhaGrupo);
    frmProdAgrpAddLinhaGrupo.ShowModal;
  Finally
    If Assigned(frmProdAgrpAddLinhaGrupo.listaImportacao) Then
    Begin
      lstProdImportLinhaGrupo := frmProdAgrpAddLinhaGrupo.listaImportacao;
      fImportarProdutosListaLinhaGrupo;
    End;

    FreeAndNil(frmProdAgrpAddLinhaGrupo);
  End;
end;

procedure TfrmProdutosAgrupados.btnCancelarEntradaClick(Sender: TObject);
begin
  inherited;

  Close;
end;

procedure TfrmProdutosAgrupados.pTrocaPai;
begin
  If (cdsConsulta.Active) And(cdsConsulta.RecordCount <= 0) Then
  Begin
    pSetFocus(edtCodIte);
    Exit;
  End;

  With cdsConsulta Do
  Begin
    Edit;
    FieldByName('AGR_ITEPAI').AsString
         :=IIF(FieldByName('AGR_ITEPAI').AsString = 'S','N','S');
    Post;
  End;
end;

procedure TfrmProdutosAgrupados.pVerificaSeEhPai;
  var
   strMsg : string;
   qryGen : TUniQuery;
begin
  qryGen:=fCriaQuery(Self);
  Try
    qryGen.SQL.Text:='SELECT GROUP_CONCAT(CONCAT(''"'',AGR_CODAGR,''"'')) FROM CADAGR '+
                     ' WHERE AGR_ITEPAI=''S'' AND '+
                     ' AGR_CODITE=:AGR_CODITE AND '+
                     ' AGR_CODAGR<>:AGR_CODAGR    ';

    With cdsConsulta Do
    Begin
      DisableControls;

      First;
      If not IsEmpty Then
      Begin

        While Not Eof Do
        Begin
          If FieldByName('AGR_ITEPAI').AsString = 'S' Then
          Begin
            qryGen.Close;
            qryGen.ParamByName('AGR_CODITE').AsString:=FieldByName('AGR_CODITE').AsString;
            qryGen.ParamByName('AGR_CODAGR').AsString:=FieldByName('AGR_CODAGR').AsString;
            qryGen.Open;

            If not fEmptyStr(qryGen.Fields[0].AsString) Then
            Begin
              strMsg:=strMsg+'('+FieldByName('AGR_CODITE').AsString+')'+' PAI EM: '+
                                qryGen.Fields[0].AsString+#13;
            End;
          End;

          Next;
        End;

        If Not fEmptyStr(strMsg) Then
        Begin
          strMsg:='OS SEGUINTES ITENS JÁ SÃO PAIS NOS AGRUPAMENTOS: '+#13+strMsg+#13+
                  'UM ITEM PODE SER PAI DE SOMENTE UM AGRUPAMENTO !'+#13+
                  'É PERMITIDO QUE UM ITEM FIGURE COMO FILHO EM MAIS QUE UM AGRUPAMENTO.';
        End;

      End;

      EnableControls;
    End;
  Finally
    FreeAndNil(qryGen);
    If Not fEmptyStr(strMsg) Then
    Begin
      pMensagemOk(strMsg);
      Abort;
    End
  End;
end;

function TfrmProdutosAgrupados.fVerificaAgrupamentos(strCodIte: string):string;
 Var
  qryGen : TUniQuery;
begin
  If Not fEmptyStr(edtCodAgr.Text) Then
  Begin
    Result:=edtCodAgr.Text;
    Exit;
  End;

  qryGen:=fCriaQuery(Self);
  Try
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT DISTINCT AGR_CODAGR AS CODAGR FROM CADAGR WHERE AGR_CODITE='+QuotedStr(strCodIte));
      Open;
      Last;
    End;

    If qryGen.RecordCount >= 1 Then
    Begin
      If qryGen.RecordCount > 1 Then
      Begin
        Try
          pCriarFormularios(TfrmProdutosAgrupadosItens,frmProdutosAgrupadosItens);

          frmProdutosAgrupadosItens.Top   :=Self.Top+
                                            Self.pnlCabecalho.Top+
                                            Self.edtCodAgr.Height+
                                            Self.edtCodAgr.Top;

          frmProdutosAgrupadosItens.Left  :=Self.Left+
                                            Self.pnlCabecalho.Left+
                                            Self.edtCodAgr.Left+
                                            Self.edtCodAgr.Width;

          frmProdutosAgrupadosItens.Height:=Self.Height-150;
          
          frmProdutosAgrupadosItens.strCodIte:=strCodIte;
          frmProdutosAgrupadosItens.ShowModal;

          Result:=frmProdutosAgrupadosItens.strCodAgr;

        Finally
          FreeAndNil(frmProdutosAgrupadosItens);
        End;
      End
      Else
      Begin
        Result:=qryGen.FieldByName('CODAGR').AsString;
      End;
    End;

  Finally
    FreeAndNil(qryGen);

    If Result='EXIT' Then
    Begin
      pDeletaTemporaria;
      Abort;
    End
  End;
end;

procedure TfrmProdutosAgrupados.dbgItensDblClick(Sender: TObject);
begin
  inherited;

  pTrocaPai;
end;

procedure TfrmProdutosAgrupados.btnTrocaPaiClick(Sender: TObject);
begin
  inherited;

  pTrocaPai;
end;

procedure TfrmProdutosAgrupados.btnPesquisaClick(Sender: TObject);
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
Begin
  inherited;

  chrKey := '/' ;

  If fPesqItem(conIteAgregados, Self, edtCodIte, nil, qryConIte, chrKey, arrSel, True, nil, 'Consulta de Itens', '1') Then
  Begin
    edtCodIte.Text := qryConIte.FieldByName('ITE_CODITE').AsString;
    pSetFocus(edtCodIte);
  End;

End;

End.


