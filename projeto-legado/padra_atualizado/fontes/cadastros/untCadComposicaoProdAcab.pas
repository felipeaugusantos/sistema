unit untCadComposicaoProdAcab;

interface

uses
  Windows, Classes, Controls, Forms, untPai, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, Grids, DBGridCitel, DBGrids, EditFocus, Uni, DB, UniClientDataSet, UniDataSetProvider,
  BitBtnLockedIncrem, MemDS, DBAccess, Provider, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade, Vcl.Mask, Vcl.DBCtrls, DBEditFocus,
  System.ImageList, Vcl.ImgList, StrUtils;

type
  TfrmCadComposicaoProdAcab = class(TfrmPai)
    pnlGeral: TPanel;
    pnlCompos: TPanel;
    Label1: TLabel;
    edtDesCom: TEditFocus;
    edtCodCom: TEditFocus;
    pnlSubProdutos: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    edtDesSubProduto: TEditFocus;
    edtSubProduto: TEditFocus;
    edtSubReferencia: TEditFocus;
    edtSubUnidade: TEditFocus;
    edtSubQtdIte: TEditFocus;
    dbgDados: TDBGridCitel;
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    cdsConsultaMAX_SEQGER: TAggregateField;
    Label5: TLabel;
    btnConfirma: TBitBtnLocked;
    btnApaga: TBitBtnLocked;
    btnCarCom: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    cdsConsultaSUM_TOTCUS: TAggregateField;
    Panel1: TPanel;
    dbeTotCus: TDBEditFocus;
    Label7: TLabel;
    imgLista: TImageList;
    chbImprime: TCheckBox;
    procedure edtCodComExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodComKeyPress(Sender: TObject; var Key: Char);
    procedure edtSubProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnApagaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCarComClick(Sender: TObject);
    procedure dbgDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgDadosDrawColumnCell(Sender: TObject; const [Ref] Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    qryConIte: TUniQuery;
    qryGenDet: TUniQuery;
    strSeqGer: String;
    strSequenAlt: String;
    strAutoInc  : String;

    procedure pHabilitaCampos;
    procedure pLimparDados;
    procedure pCarregaEstrutura;
    procedure pCarregaSubProduto(qryConsulta: TUniQuery);
    procedure pAtualizaTemporaria(intPosicao: Integer);
    procedure pCarregaItemAlteracao;
    procedure pApagaItem;
    procedure pDeletaTemporaria;
    procedure pAcertaSequencialItem;

    function fBuscaEstrutura: String;
    function fRetSeqGer: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    procedure pGravaTemporaria(strCodIte, strDescri: String; fltQtdIte: Double; strRefere, strUnidad: String; blnImprime : Boolean);
  public
    { Public declarations }
  end;

implementation

uses SysUtils, Variants, untFuncoesSimples, untConsultas, untPesqAux,
     untComposicaoProdAcab, untTypesSistema, untConstantes;

{$R *.dfm}

procedure TfrmCadComposicaoProdAcab.btnCarComClick(Sender: TObject);
begin
  inherited;
  fBuscaEstrutura;
end;

procedure TfrmCadComposicaoProdAcab.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
  Begin
    pSetFocus(edtSubProduto);
    Exit;
  End;

  pGravaTemporaria(edtSubProduto.Text, edtDesSubProduto.Text, fStrToFloat( edtSubQtdIte.Text ),
                   edtSubReferencia.Text, edtSubUnidade.Text, chbImprime.Checked);
  pLimparDados;
  pSetFocus(edtSubProduto);
  btnConfirma.Enabled   := True;
  chbImprime.Checked := True;
end;

procedure TfrmCadComposicaoProdAcab.btnApagaClick(Sender: TObject);
Var
  strSql: String;
  qryGenCpa : TUniQuery;
begin
  inherited;
  Try
    Try
      qryGenCpa := fCriaQuery(Self);

      If (fEmptyStr(edtCodCom.Text)) Then
      Begin
        fMensagem('AVISO','É necessário selecionar uma composição antes.', ['&O K']);
        Exit;
      End;

      If ( fMensagem( '', 'Apagar a composição?', ['&Sim', '&Não'], 2 ) = 2 ) Then
        Exit;

      With qryGenCpa Do
      Begin
        strSql := '';
        strSql := strSql + ' DELETE FROM GERCOM ';
        strSql := strSql + ' WHERE GCO_CODCOM = :CODCOM ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName( 'CODCOM' ).AsString := edtCodCom.Text;
        ExecSql;
        Close;

        If qryGenCpa.RowsAffected > 0Then
        Begin
          fVerificaIntegridade('frmCadComposicaoProdAcab', 'GERCOM', qryTabela, True);

          If Not(qryGenDet.IsEmpty)Then
          Begin
            qryGenDet.First;
            While Not(qryGenDet.eof) do
            Begin
              fVerificaIntegridade('frmCadComposicaoProdAcab', 'DETCOM', qryGenDet, True);
              qryGenDet.Next;
            End;
          End;

        End;

      End;

      pLimparDados;
      pDeletaTemporaria;

      dbgDados.Refresh;
      pnlCompos.Enabled    := True;
      pnlSubProdutos.Enabled := False;
      edtCodCom.Clear;
      pSetFocus(edtDesCom);
      edtDesCom.Clear;
      dbgDados.Enabled       := False;
      btnConfirma.Enabled    := False;
    Except
      On E: EUniError Do
      Begin
        Case E.ErrorCode of
          ERROR_FOREIGN_KEY_DELETE : fMensagem('ATENÇÃO!','Não é possível excluir essa composição, pois existe produtos relacionados a ela!',['&O K']);
        Else
          pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, ' [TfrmCadComposicaoProdAcab.btnApagaClick] ');
        end;
      End;

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'Excluir registro');
      End;
    END;
  Finally
    FreeAndNil(qryGenCpa);
  End;
end;

procedure TfrmCadComposicaoProdAcab.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimparDados;
  pSetFocus(edtSubProduto);
end;

procedure TfrmCadComposicaoProdAcab.btnConfirmaClick(Sender: TObject);
Var
  strSQL     : String;
  qryGerCpa  : TUniQuery;
  strSequen  : String;
  blnConfirma: Boolean;
begin
  inherited;
  If (cdsConsulta.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos 1 subproduto!', ['&Ok']);
    Exit;
  End;

  Try

    fStartTransaction;

    strAutoInc := fCampoTabela('AUTOINCREM', 'GERCOM', ['GCO_CODCOM'], [edtCodCom.Text]);
    qryGerCpa := fCriaQuery(Self);
    If fEmptyStr(strAutoInc) Then
    Begin
      Try
        strSQL := '';
        strSQL := strSQL + 'DELETE FROM ';
        strSQL := strSQL + '  GERCOM ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  GCO_CODCOM = :CODCOM ';

        With qryGerCpa Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODCOM').AsString := edtCodCom.Text;
          ExecSQL;
          blnConfirma := True;
          Close;
        End;

      Finally
        FreeAndNil(qryGerCpa);
      End;

      {***********************************}
      {* EFETUA A GRAVAÇÃO NO BANCO      *}
      {********************************LB*}
      If (blnConfirma) Then
        blnConfirma := fGravaGerCom(strAutoInc,
                                    VS_strCodEmp,
                                    edtCodCom.Text,
                                    edtDesCom.Text);
    End
    Else
    Begin
      Try

        strSQL := '';
        strSQL := strSQL + 'UPDATE GERCOM';
        strSQL := strSQL + '  SET GCO_DESCOM = :DESCOM ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

        With qryGerCpa Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('AUTINC').AsString := strAutoInc;
          ParamByName('DESCOM').AsString := edtDesCom.Text;
          ExecSQL;
          blnConfirma := True;
          Close;
        End;



        strSQL := '';
        strSQL := strSQL + 'DELETE FROM ';
        strSQL := strSQL + '  DETCOM ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  DCO_SEQGER = :SEQGER ';

        With qryGerCpa Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('SEQGER').AsString := strAutoInc;
          ExecSQL;
          blnConfirma := True;
          Close;
        End;

      Finally
        FreeAndNil(qryGerCpa);
      End;

    end;

    If (blnConfirma) Then
    Begin
      blnConfirma := False;

      With cdsConsulta Do
      Begin
        strSequen := '0';
        First;

        While Not (Eof) Do
        Begin
          strSequen := IntToStr(StrToInt(strSequen) + 1);

          blnConfirma := fGravaDetCom(strAutoInc,
                                      strSequen,
                                      VS_strCodEmp,
                                      FieldByName('DCO_CODITE').AsString,
                                      FieldByName('DCO_QTDITE').AsFloat,
                                      FieldByName('DCO_DESCRI').AsString,
                                      FieldByName('DCO_REFERE').AsString,
                                      FieldByName('DCO_UNIDAD').AsString,
                                      FieldByName('DCO_IMP_OP').AsString);

          If (Not blnConfirma) Then
            Break;

          Next;
        End;
      End;
    End;

    If (blnConfirma) Then
    Begin
      fCommit;
      fMensagem('', 'Composição gravada com sucesso!', ['&O k']);

      pLimparDados;
      pDeletaTemporaria;

      dbgDados.Refresh;
      pnlCompos.Enabled    := True;
      pnlSubProdutos.Enabled := False;
      //edtCodCom.ReadOnly     := False;
      edtCodCom.Clear;
      pSetFocus(edtDesCom);
      edtDesCom.Clear;
      dbgDados.Enabled       := False;
      btnConfirma.Enabled    := False;
    End
    Else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(e.Message, '[TfrmCadComposicaoProdAcab.btnConfirmaClick]');
    End;
  End;
end;

procedure TfrmCadComposicaoProdAcab.dbgDadosDrawColumnCell(Sender: TObject;
  const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if SameText(Column.Field.FieldName, 'DCO_IMP_OP') then
  Begin
    TDBGridCitel(Sender).Canvas.FillRect(Rect);
    If (Column.Field.AsString = 'S') then
      imgLista.Draw(TDBGridCitel(Sender).Canvas, Rect.Left+1, Rect.Top+1, 1)
    Else
      imgLista.Draw(TDBGridCitel(Sender).Canvas, Rect.Left+1, Rect.Top+1, 2);

  end;
end;

procedure TfrmCadComposicaoProdAcab.dbgDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_RETURN) Then
    pCarregaItemAlteracao
  Else If (Key = VK_DELETE) Then
    pApagaItem
  Else If (Key = VK_ESCAPE) And (edtSubProduto.CanFocus) Then
    pSetFocus(edtSubProduto);

end;

procedure TfrmCadComposicaoProdAcab.edtCodComExit(Sender: TObject);
begin
  inherited;

 { If fEmptyStr(edtDesCom.Text) And (Not fEmptyStr(edtCodCom.Text))  Then
  Begin
    fMensagem('AVISO','Código da Composição não encontrado.', ['&O K']);
    edtCodCom.Clear;
    pSetFocus(edtCodCom);
  End;

  If ( Not fEmptyStr(edtCodCom.Text) ) Then
  Begin
    pCarregaProduto(qryConIte);  //VERIFICAR SE TEM QUE FILTRAR O DEPARTAMENTO
    pSetFocus(edtSubProduto);
  End;}
end;

procedure TfrmCadComposicaoProdAcab.edtCodComKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  //filtra por produto acabado
  If fEntraCons(Key) Then
  Begin
    if fPesqComposicao(Self, edtCodCom, edtDesCom, qryConIte, Key, arrSel, True) then
    Begin
      pHabilitaCampos;
      pSetFocus(edtSubProduto);
      pCarregaEstrutura;
    End;
  End;

end;

procedure TfrmCadComposicaoProdAcab.edtSubProdutoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    Try
      //filtra por produto embalagem
      if fPesqItem(conIteSimples, Self, edtSubProduto, edtDesSubProduto, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1',
                   '',0,False,False,0,cdrCodIte,'',False,'','',True,False,True,'',False, False, True) then
      Begin
        edtSubReferencia.Text := qryConIte.FieldByName('ITE_REFERE').AsString;
        edtSubUnidade.Text    := fRetSiglaUni(qryConIte.FieldByName('ITE_CODUNI').AsString);
        SelectNext(ActiveControl, True, True);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmCadEstruturas.edtSubProdutoKeyPress]');
      End;
    End;

  End;
end;

function TfrmCadComposicaoProdAcab.fBuscaEstrutura: String;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
begin

  qryTabela := fCriaQuery(Self);

  chrKey := '/';

  If fPesqComposicao(Self, edtCodCom, edtDesCom, qryTabela, chrKey, arrSel) Then
  Begin
    edtCodCom.Text := qryTabela.FieldByName('GCO_CODCOM').AsString;
    edtDesCom.Text := qryTabela.FieldByName('GCO_DESCOM').AsString;

    pHabilitaCampos;
    pCarregaEstrutura;
    pAtualizaTemporaria(1);
    pSetFocus(edtSubProduto);

    If Not(fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
    Begin
      qryGenDet.Close;
      qryGenDet.SQL.Clear;
      qryGenDet.SQL.Add('SELECT * FROM DETCOM WHERE ');
      qryGenDet.SQL.Add('DCO_SEQGER = "'+qryTabela.FieldByName('AUTOINCREM').AsString+'"');
      qryGenDet.Open;
    End;

  End;

end;

procedure TfrmCadComposicaoProdAcab.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDeletaTemporaria;

  If Assigned(qryConIte) Then
    FreeAndNil(qryConIte);

  If Assigned(qryGenDet) Then
    FreeAndNil(qryGenDet);

end;

procedure TfrmCadComposicaoProdAcab.FormCreate(Sender: TObject);
  Var
    intIndex : Integer;
begin
  inherited;
  pSetaCodIte(edtSubProduto);

  pDeletaTemporaria;

  dbgDados.Refresh;
  pnlCompos.Enabled    := True;
  pnlSubProdutos.Enabled := False;
  dbgDados.Enabled       := False;
  btnConfirma.Enabled    := False;
  edtSubQtdIte.EditFormat := fMskDigitos(4);
  edtSubQtdIte.Text       := FormatFloat(edtSubQtdIte.EditFormat, 0);

  qryGenDet := fCriaQuery(Self);


  If (fCfgSis('MDORIN', varString) <> '6') Then
  Begin
    chbImprime.Visible := False;

    For intIndex := 0 To dbgDados.Columns.Count -1 Do
    Begin
      If dbgDados.Columns[intIndex].FieldName = 'DCO_IMP_OP' Then
      Begin
        dbgDados.Columns[intIndex].Visible := False;
        Break;
      End;
    End;
  End;

end;

procedure TfrmCadComposicaoProdAcab.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) And (ActiveControl.Parent = pnlSubProdutos) Then
  Begin

    Key := 0;

    If ( fMensagem( '', 'Cancela edição da Estrutura?', ['&Sim', '&Não'], 2 ) = 2 ) Then
      Exit;

    pLimparDados;
    pDeletaTemporaria;

    dbgDados.Refresh;
    pnlCompos.Enabled    := True;
    pnlSubProdutos.Enabled := False;
    //edtCodCom.ReadOnly   := False;
    edtCodCom.Clear;
    pSetFocus(edtDesCom);
    edtDesCom.Clear;
    dbgDados.Enabled       := False;
    btnConfirma.Enabled    := False;
  End;

  inherited;

  If btnConfirma.Enabled Then
  Begin
    If (Key = VK_F10) Then
      btnConfirma.Click;
  End;

  If btnApaga.Enabled Then
  Begin

    If (Key = VK_F3) Then
    Begin
      btnApaga.Click;
      Key := 0;
    End;

  End;

  If btnCarCom.Enabled Then
  Begin

    If (Key = VK_F2) Then
    Begin
      btnCarCom.Click;
      Key := 0;
    End;

  End;

end;

procedure TfrmCadComposicaoProdAcab.FormShow(Sender: TObject);
begin
  inherited;
  qryConIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

function TfrmCadComposicaoProdAcab.fRetSeqGer: String;
begin
  With cdsConsulta Do
  Begin
    If TAggregateField(FieldByName('MAX_SEQGER')).Value = Null Then
      Result := '1'
    Else
      Result := IntToStr(Trunc(TAggregateField(FieldByName('MAX_SEQGER')).Value) + 1);
  End;
end;

function TfrmCadComposicaoProdAcab.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {If (Sender = edtCodCom) Then
    Begin
      If Not fEmptyStr(edtCodCom.Text) Then
      Begin
        pCarregaProduto(qryConIte);
        If blnValidaIndividual Then
        Begin
          pCarregaEstrutura;
          pAtualizaTemporaria(1);
          pHabilitaCampos;
        End;
      End
      Else If (blnValidaIndividual) Then
      Begin
        pHabilitaCampos;
        pCarregaEstrutura;

        If (edtSubProduto.CanFocus) Then
        Begin
          pSetFocus(edtSubProduto);
          blnMudarFoco := False;
        End;
      End;
    End }

    If (Sender = edtDesCom) Then
    Begin
      If (fEmptyStr(edtDesCom.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Composição deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (blnValidaIndividual) Then
      Begin
        pHabilitaCampos;
        pCarregaEstrutura;
        pAtualizaTemporaria(1);        

        If (edtSubProduto.CanFocus) Then
        Begin
          pSetFocus(edtSubProduto);
          blnMudarFoco := False;
        End;
      End;
    End

    Else If (Sender = edtSubProduto) Then
    Begin

      If (fEmptyStr(edtSubProduto.Text)) Then
      Begin

        pLimparDados;

        If (Not cdsConsulta.IsEmpty) And (blnValidaIndividual) Then
        Begin
          pSetFocus(dbgDados);
          blnMudarFoco := False;
        End
        Else
        Begin
          fMensagem('AVISO','Código do Produto não encontrado.', ['&O K']);
          Result := False;
        End;

      End
      Else
      Begin

        If Not fEmptyStr(edtSubProduto.Text) Then
          pCarregaSubProduto(qryConIte);

        If fEmptyStr(edtDesSubProduto.Text) And (Not fEmptyStr(edtSubProduto.Text))  Then
        Begin
          fMensagem('AVISO','Código do Produto não encontrado.', ['&O K']);
          Result := False;
        End;

      End;

    End
    Else
    If (Sender = edtSubQtdIte) Then
    Begin

      If Not fEmptyStr(edtSubProduto.Text) Then
      Begin

        If fEmptyStr(edtSubQtdIte.Text) Then
        Begin
          fMensagem('ATENÇÃO','Digite a quantidade do produto!',['&O K']);
          Result := False;
        End
        Else
        If fStrToFloat(edtSubQtdIte.Text) <= 0.00 Then
        Begin
          fMensagem('ATENÇÃO','A quantidade do produto deve ser maior que Zero !',['&O K']);
          Result := False;
        End;

      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadComposicaoProdAcab.pApagaItem;
begin
  If (Not cdsConsulta.IsEmpty) Then
  Begin
    cdsConsulta.Delete;
    pAcertaSequencialItem;
  End;
end;

procedure TfrmCadComposicaoProdAcab.pAtualizaTemporaria(intPosicao: Integer);
begin
  With cdsConsulta Do
  Begin
    If (RecordCount > 0) And (RecordCount >= intPosicao) Then
      RecNo := intPosicao;

    (FieldByName('DCO_QTDITE') As TFloatField).DisplayFormat := edtSubQtdIte.EditFormat;
  End;
end;

procedure TfrmCadComposicaoProdAcab.pCarregaEstrutura;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + '  SELECT ';
  strSQL := strSQL + '    DCO_SEQUEN, ';
  strSQL := strSQL + '    DCO_CODEMP, ';
  strSQL := strSQL + '    DCO_CODITE, ';
  strSQL := strSQL + '    DCO_QTDITE, ';

  strSQL := strSQL + '    DCO_DESCRI, ';
  strSQL := strSQL + '    DCO_REFERE, ';
  strSQL := strSQL + '    DCO_UNIDAD, ';

  strSQL := strSQL + '    DCO_REFERE, ';
  strSQL := strSQL + '    DCO_UNIDAD, ';
  strSQL := strSQL + '    DCO_IMP_OP, ';

  strSQL := strSQL + '    DCO_SEQGER, ';
  strSQL := strSQL + '    E.ITE_PRECUS, ';
  strSQL := strSQL + '    DCO_QTDITE * E.ITE_PRECUS AS TOTCUS ';

  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    GERCOM G ';
  strSQL := strSQL + '    INNER JOIN DETCOM D ON D.DCO_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + '    LEFT  JOIN CADITE C ON C.ITE_CODITE = D.DCO_CODITE ';
  strSQL := strSQL + '    LEFT  JOIN ITEGER E ON E.ITE_CODITE = C.ITE_CODITE ';
  strSQL := strSQL + '                       AND E.ITE_CODEMP = :CODEMP      ';

  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '    G.GCO_CODCOM = :CODCOM ';

  With qryConsulta Do
  Begin
    cdsConsulta.Close;
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCOM').AsString := edtCodCom.Text;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    pSetaClient(qryConsulta);

    cdsConsulta.Open;
    pSetaClient(cdsConsulta);

    TFloatField(cdsConsulta.FieldByName('DCO_QTDITE')).DisplayFormat := edtSubQtdIte.EditFormat;
    TFloatField(cdsConsulta.FieldByName('DCO_QTDITE')).EditFormat    := edtSubQtdIte.EditFormat;
    TFloatField(cdsConsulta.FieldByName('ITE_PRECUS')).DisplayFormat := fMskDigitos(2);
    TFloatField(cdsConsulta.FieldByName('TOTCUS')).DisplayFormat     := fMskDigitos(4);

    cdsConsulta.IndexFieldNames := 'DCO_SEQUEN';
  End;

  If Not cdsConsulta.IsEmpty Then
  Begin
    strSeqGer := cdsConsulta.FieldByName('DCO_SEQGER').AsString;
    btnConfirma.Enabled   := True;
  End;
end;

procedure TfrmCadComposicaoProdAcab.pCarregaItemAlteracao;
begin
  If (Not cdsConsulta.IsEmpty) Then
  Begin
    strSequenAlt := cdsConsulta.FieldByName('DCO_SEQUEN').AsString;
    edtSubProduto.Text := cdsConsulta.FieldByName('DCO_CODITE').AsString;
    pCarregaSubProduto(qryConIte);
    chbImprime.Checked := (cdsConsulta.FieldByName('DCO_IMP_OP').AsString = 'S');

    edtSubQtdIte.Text := FormatFloat(edtSubQtdIte.EditFormat, cdsConsulta.FieldByName('DCO_QTDITE').AsFloat);
  End;

  pSetFocus(edtSubProduto);
end;

procedure TfrmCadComposicaoProdAcab.pCarregaSubProduto(qryConsulta: TUniQuery);
begin
  pPesquisaCadIte(qryConsulta, qryConsulta, edtSubProduto.Text, '', False,
  False, True, True, False, True);
  With qryConsulta Do
  Begin
    edtDesSubProduto.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;
    edtSubReferencia.Text := qryConsulta.FieldByName('ITE_REFERE').AsString;
    edtSubUnidade.Text    := fRetSiglaUni(qryConsulta.FieldByName('ITE_CODUNI').AsString);
  End;
end;

procedure TfrmCadComposicaoProdAcab.pDeletaTemporaria;
begin
  If cdsConsulta.Active Then
    cdsConsulta.EmptyDataSet;
end;

procedure TfrmCadComposicaoProdAcab.pGravaTemporaria(strCodIte, strDescri: String; fltQtdIte: Double;
 strRefere, strUnidad: String; blnImprime : Boolean);
  Var
    strSequen: String;
begin
  If fEmptyStr(strSequenAlt) Then
  Begin
    With cdsConsulta Do
    Begin
      strSequen := fRetSeqGer;
      Insert;
      FieldByName('DCO_CODITE').AsString  := strCodIte;
      FieldByName('DCO_SEQUEN').AsString  := strSequen;
      FieldByName('DCO_CODEMP').AsString  := VS_strCodEmp;
      FieldByName('DCO_QTDITE').AsFloat   := fltQtdIte;
      FieldByName('DCO_SEQGER').AsInteger := 1;
      FieldByName('DCO_DESCRI').AsString  := strDescri;
      FieldByName('DCO_REFERE').AsString  := strRefere;
      FieldByName('DCO_UNIDAD').AsString  := strUnidad;
      FieldByName('DCO_IMP_OP').AsString  := IfThen(blnImprime, 'S', 'N');
      FieldByName('ITE_PRECUS').AsFloat   := fCampoTabela('ITE_PRECUS', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, VS_strCodEmp]);
      FieldByName('TOTCUS').AsFloat       := FieldByName('ITE_PRECUS').AsFloat * fltQtdIte;
      Post;
    End;
  End
  Else
  Begin
    cdsConsulta.Edit;
    cdsConsulta.FieldByName('DCO_QTDITE').AsFloat  := fltQtdIte;
    cdsConsulta.FieldByName('TOTCUS').AsFloat      := cdsConsulta.FieldByName('ITE_PRECUS').AsFloat * fltQtdIte;
    cdsConsulta.FieldByName('DCO_IMP_OP').AsString := IfThen(blnImprime, 'S', 'N');
    cdsConsulta.Post;
  End;

  strSequenAlt := '';
end;

procedure TfrmCadComposicaoProdAcab.pHabilitaCampos;
begin
  pnlSubProdutos.Enabled := True;
  dbgDados.Enabled       := True;
//  pnlCompos.Enabled      := False;
end;

procedure TfrmCadComposicaoProdAcab.pLimparDados;
begin
  edtSubProduto.Clear;
  edtDesSubProduto.Clear;
  edtSubReferencia.Clear;
  edtSubUnidade.Clear;
  edtSubQtdIte.Clear;
  edtSubQtdIte.Text := FormatFloat(edtSubQtdIte.EditFormat, 0);
  strSeqGer := '';
end;

procedure TfrmCadComposicaoProdAcab.pAcertaSequencialItem;
Var
  intRecNo: Integer;
begin

  Try

    With cdsConsulta Do
    Begin
      intRecNo := RecNo;

      DisableControls;
      First;

      While Not Eof Do
      Begin
        If (FieldByName('DCO_SEQUEN').AsInteger <> RecNo) Then
        Begin
          Edit;
          FieldByName('DCO_SEQUEN').AsString := IntToStr(RecNo);
          Post;
        End;

        Next;
      End;

      RecNo := intRecNo;
      EnableControls;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmCadEstruturasIndustrial.pAcertaSequencialItem]');
  End;

end;

end.

