unit untCfgPortadoresAutorizadosEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus,
  untTypesSistema, Vcl.Mask, MaskEditFocus, Uni, UniClientDataSet,
  UniDataSetProvider, cxProgressBar, untPai;

type
  TfrmCfgPortadoresAutorizadosEmail = class(TfrmPai)
    pnlHeader: TPanel;
    lblCliente: TLabel;
    edtCodPortador: TEditFocus;
    edtDesPortador: TEditFocus;
    dtsPortadoresAut: TDataSource;
    pnlClientes: TPanel;
    cxGrdportadoresAut: TcxGridCitel;
    cxGrdportadoresAutLevel: TcxGridLevel;
    cxGrdportadoresAutTableView: TcxGridDBTableViewCitel;
    cxGrdportadoresAutTableViewPOR_CODPOR: TcxGridDBColumn;
    cxGrdportadoresAutTableViewPOR_NOMPOR: TcxGridDBColumn;
    Panel1: TPanel;
    Label5: TLabel;
    Label1: TLabel;
    btnAdicPortador: TBitBtnLocked;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    procedure FormResize(Sender: TObject);
    procedure edtCodPortadorKeyPress(Sender: TObject; var Key: Char);
    procedure mskCgcCpfChange(Sender: TObject);
    procedure btnAdicPortadorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cxGrdportadoresAutTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    cdsPortadoresAut: TUniClientDataSet;

    btnExclui : Boolean;

    function  fAdicionaPortador(pgbProgresso: TcxProgressBar): Boolean;
    procedure pCriaDataSetPortadoresAut;
    procedure pCarregaPortadoresAutorizados;
    procedure pEfetivaDados;
    procedure pCriaCampo(Nome: String; Tipo: TFieldType; Tamanho: Integer = 0);
    procedure pHabBotoes(blnHab: Boolean);
    function fVerificaJaCadastrado(strCodPor: String): Boolean;
    procedure ExcluiPortador;

  public
    { Public declarations }
    strSeqGer: String;
    strCodGru: String;
    intCodTip: Integer;
  protected
    { Protected declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untConsultas, untFuncoesSimples, untGravando, untFuncoesGenerica;

{$R *.dfm}

procedure TfrmCfgPortadoresAutorizadosEmail.btnAdicPortadorClick(Sender: TObject);
begin
  inherited;

  If Not fValidaCampos(edtCodPortador, True) Then
     Exit;

  pCriarFormularios(TfrmGravando,frmGravando);
  Try
    frmGravando.fExecutarAcao := fAdicionaPortador;
    frmGravando.lblGravando.Caption := 'Aguarde... Adicionando Portador.';
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;

  pSetFocus(edtCodPortador);

end;

procedure TfrmCfgPortadoresAutorizadosEmail.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pnlHeader.Enabled := False;
  pHabBotoes(True);
  edtCodPortador.Clear;
  edtdesPortador.Clear;
  pCarregaPortadoresAutorizados;
end;

procedure TfrmCfgPortadoresAutorizadosEmail.btnExcluirClick(Sender: TObject);
begin
  inherited;

  if cdsPortadoresAut.IsEmpty then
     Exit;

  If fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1 Then
  Begin
     ExcluiPortador();
  End;

end;

Procedure TfrmCfgPortadoresAutorizadosEmail.ExcluiPortador();
Begin

  If Not cdsPortadoresAut.IsEmpty Then
  Begin
    btnExclui := True;

    If cdsPortadoresAut.FieldByName('AUTOINCREM').IsNull then
       cdsPortadoresAut.Delete
    Else
    Begin
      cdsPortadoresAut.Edit;
      cdsPortadoresAut.FieldByName('STATUS').AsInteger := 3; //excluído
      cdsPortadoresAut.Post;

      btnGravarClick( btnGravar );
    End;
  End;

End;

procedure TfrmCfgPortadoresAutorizadosEmail.btnGravarClick(Sender: TObject);
 Var strMsg : String;
begin
  Try
    fStartTransaction;

    pEfetivaDados;

    fCommit;

    If btnExclui Then
       strMsg := 'Registro excluído com sucesso!'
    Else
       strMsg := 'Dados gravados com sucesso!';

    pMensagemOK(strMsg);

    btnExclui := False;

    pCarregaPortadoresAutorizados;
    pHabBotoes(True);
    pnlHeader.Enabled := False;

    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro('Ocorreu um erro ao gravar os Portadores. Erro gerado: ' + E.Message, '[untCfgPortadoresAutorizadosEmail.btnConfirmaClick]');
    End;
  End;
end;

procedure TfrmCfgPortadoresAutorizadosEmail.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pnlHeader.Enabled := True;
  pHabBotoes(False);
  psetfocus(edtcodPortador);
end;

procedure TfrmCfgPortadoresAutorizadosEmail.cxGrdportadoresAutTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  //If Key = VK_DELETE Then
  //  btnRemoveClienteClick(Sender);
end;

procedure TfrmCfgPortadoresAutorizadosEmail.edtCodPortadorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

 {If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrConsulta) Then
  Begin
    If fValidaCampos(edtCodCli, False) Then
      SelectNext(ActiveControl, True, True);
  End; }

  If fPesqPortador(conSimples,
                   Self,
                   edtCodPortador,
                   edtDesPortador,
                   nil,
                   Key,
                   arrSel,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False) then
  Begin
    If (fValidaCampos(edtCodPortador, False)) Then
        Self.SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmCfgPortadoresAutorizadosEmail.fAdicionaPortador(pgbProgresso: TcxProgressBar): Boolean;
begin

  Result := True;
  Try
     cdsPortadoresAut.Append;
     cdsPortadoresAut.FieldByName('POR_CODPOR').AsString  := edtCodPortador.text;
     cdsPortadoresAut.FieldByName('POR_NOMPOR').AsString  := edtDesPortador.Text;
     cdsPortadoresAut.FieldByName('STATUS'    ).AsInteger := 1;
     cdsPortadoresAut.Post;

     edtCodPortador.Clear;
     edtdesPortador.Clear;

  Except
     Result := false;
  End;

end;

procedure TfrmCfgPortadoresAutorizadosEmail.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(cdsportadoresAut);
end;

procedure TfrmCfgPortadoresAutorizadosEmail.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSetPortadoresAut;
  dtsPortadoresAut.DataSet := cdsPortadoresAut;
end;

procedure TfrmCfgPortadoresAutorizadosEmail.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #27 Then
    btnSair.Click;
end;

procedure TfrmCfgPortadoresAutorizadosEmail.FormResize(Sender: TObject);
begin
  inherited;
  //pnlPesquisa.Width := (Self.ClientWidth div 2) - (pnlAddRemove.Width div 2);
end;

procedure TfrmCfgPortadoresAutorizadosEmail.FormShow(Sender: TObject);
begin
  inherited;
  pnlHeader.Enabled := False;
  pCarregaPortadoresAutorizados;
  pHabBotoes(True);
  psetFocus(BtnIncluir);
end;

function TfrmCfgPortadoresAutorizadosEmail.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodPortador) Then
    Begin

       If Not fEmptyStr(edtCodPortador.Text) Then
       Begin
          edtDesPortador.Text := fRetNomPortador(edtCodPortador.Text);

          If fEmptyStr(edtDesPortador.Text) Then
          Begin
             fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
             Result := False;
          End
          Else
          if fVerificaJaCadastrado(edtCodPortador.Text) then
          Begin
             fMensagem('ATENÇÃO!', 'Portador ja cadastrado!', ['&O k']);
             Result := False;
          End;

       End
       Else
       If fEmptyStr(edtDesPortador.Text) Then
       Begin
          fMensagem('ATENÇÃO!', 'Informe o Portador!', ['&O k']);
          Result := False;
       End;

    End

  End;

end;

procedure TfrmCfgPortadoresAutorizadosEmail.mskCgcCpfChange(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(TMaskEditFocus(Sender).Text) Then
    TMaskEditFocus(Sender).EditMask := fRetMascaraC_G_C_(fSetaPais, fSetaCgcCpf(IIF(Length(TMaskEditFocus(Sender).Text) = 14, '1', '2')))
  Else
    TMaskEditFocus(Sender).EditMask := '';
end;


procedure TfrmCfgPortadoresAutorizadosEmail.pCriaCampo(Nome: String; Tipo: TFieldType; Tamanho: Integer = 0);
begin
  cdsPortadoresAut.FieldDefs.Add(Nome, Tipo, Tamanho, False);
end;

procedure TfrmCfgPortadoresAutorizadosEmail.pCriaDataSetPortadoresAut;
begin
  cdsPortadoresAut := TUniClientDataSet.Create(Self);

  pCriaCampo('AUTOINCREM', ftString, 20);
  pCriaCampo('AEN_CODEMP', ftString, 3);
  pCriaCampo('AEN_CODGRU', ftString, 3);
  pCriaCampo('POR_CODPOR', ftString, 5);
  pCriaCampo('POR_NOMPOR', ftString, 60);
  pCriaCampo('STATUS',     ftInteger); //1-incluído; 2-alterado; 3-excluído

  cdsPortadoresAut.CreateDataSet;
  cdsPortadoresAut.LogChanges := False;
  cdsPortadoresAut.IndexFieldNames := 'POR_CODPOR';

  //cdsPortadoresAut.Filter := 'STATUS <> 3';
  //cdsPortadoresAut.Filtered := True;
end;

procedure TfrmCfgPortadoresAutorizadosEmail.pEfetivaDados;
  Var
    qryInsert, qryDelete: TUniQuery;
begin

  qryInsert := fCriaQuery(Self);
  qryDelete := fCriaQuery(Self);
  Try
    cdsPortadoresAut.DisableControls;

    //Filtered := False;

    qryInsert.SQL.Add('REPLACE INTO PORAEN( AUTOINCREM,  AEN_CODGRU,  AEN_CODCFG,  AEN_CODPOR,  AEN_CODEMP,  AEN_CODTIP)');
    qryInsert.SQL.Add('             VALUES(:AUTOINCREM, :AEN_CODGRU, :AEN_CODCFG, :AEN_CODPOR, :AEN_CODEMP, :AEN_CODTIP)');

    qryDelete.SQL.Add('DELETE FROM PORAEN ');
    qryDelete.SQL.Add('WHERE AEN_CODGRU = :AEN_CODGRU');
    qryDelete.SQL.Add('  AND AEN_CODCFG = :AEN_CODCFG');
    qryDelete.SQL.Add('  AND AEN_CODPOR = :AEN_CODPOR');
    qryDelete.SQL.Add('  AND AEN_CODEMP = :AEN_CODEMP');
    qryDelete.SQL.Add('  AND AEN_CODTIP = :AEN_CODTIP');

    cdsPortadoresAut.First;
    While Not cdsPortadoresAut.Eof Do
    Begin
      If cdsPortadoresAut.FieldByName('STATUS').AsInteger = 1 Then //incluído
      Begin
        qryInsert.Close;
        qryInsert.Params[0].AsString  := fRetAutoIncrem('PORAEN', VS_strCodEmp);
        qryInsert.Params[1].AsString  := strCodGru;
        qryInsert.Params[2].AsString  := strSeqGer;
        qryInsert.Params[3].AsString  := cdsPortadoresAut.FieldByName('POR_CODPOR').AsString;
        qryInsert.Params[4].AsString  := VS_strCodEmp;
        qryInsert.Params[5].AsInteger := IntCodTip;
        qryInsert.Execute;
      End
      Else If cdsPortadoresAut.FieldByName('STATUS').AsInteger = 3 Then //excluído
      Begin
        qryDelete.Close;
        qryDelete.Params[0].AsString  := strCodGru;
        qryDelete.Params[1].AsString  := strSeqGer;
        qryDelete.Params[2].AsString  := cdsPortadoresAut.FieldByName('POR_CODPOR').AsString;
        qryDelete.Params[3].AsString  := VS_strCodEmp;
        qryDelete.Params[4].AsInteger := IntCodTip;
        qryDelete.Execute;
      End;

      cdsPortadoresAut.Next;
    End;
  Finally
   // Filtered := True;
    cdsPortadoresAut.EnableControls;
    FreeAndNil(qryInsert);
    FreeAndNil(qryDelete);
  End;

end;

procedure TfrmCfgPortadoresAutorizadosEmail.pCarregaPortadoresAutorizados;
  Var
    qryConfig: TUniQuery;
    objField: TField;
begin

  cdsPortadoresAut.EmptyDataSet;

  qryConfig := fCriaQuery(Self);

  Try
    cdsPortadoresAut.DisableControls;

    qryConfig.SQL.Add(' SELECT PORAEN.AUTOINCREM, ');
    qryConfig.SQL.Add('       PORAEN.AEN_CODEMP,  ');
    qryConfig.SQL.Add('       PORAEN.AEN_CODGRU,  ');
    qryConfig.SQL.Add('       POR_CODPOR,         ');
    qryConfig.SQL.Add('       POR_NOMPOR,         ');
    qryConfig.SQL.Add('       0 AS STATUS         ');
    qryConfig.SQL.Add('  FROM PORAEN              ');
    qryConfig.SQL.Add('  LEFT JOIN CADPOR ON (POR_CODPOR = AEN_CODPOR) ');
    qryConfig.SQL.Add(' WHERE AEN_CODGRU = :AEN_CODGRU                 ');
    qryConfig.SQL.Add('   AND AEN_CODCFG = :AEN_CODCFG                 ');
    qryConfig.SQL.Add('   AND AEN_CODEMP = :AEN_CODEMP                 ');
    qryConfig.SQL.Add('   AND AEN_CODTIP = :AEN_CODTIP                 ');
    qryConfig.SQL.Add(' ORDER BY POR_NOMPOR                            ');

    qryConfig.Params[0].AsString  := strCodGru;
    qryConfig.Params[1].AsString  := strSeqGer;
    qryConfig.Params[2].AsString  := VS_strCodEmp;
    qryConfig.Params[3].AsInteger := intCodTip;
    qryConfig.Open;

    qryConfig.First;
    While Not qryConfig.Eof Do
    Begin
      cdsPortadoresAut.Append;
      For objField In qryConfig.Fields Do
        cdsPortadoresAut.FieldByName(objField.FieldName).Value := objField.Value;
      cdsPortadoresAut.Post;

      qryConfig.Next;
    End;

    cdsPortadoresAut.First;
  Finally
    cdsPortadoresAut.EnableControls;
    FreeAndNil(qryConfig);
  End;
end;

procedure TfrmCfgPortadoresAutorizadosEmail.pHabBotoes(blnHab : Boolean);
Begin
   btnIncluir.enabled := blnHab;
   btnExcluir.enabled := blnHab;
   btnGravar.enabled  := Not blnHab;
   btnCancela.enabled := Not blnHab;
End;

Function TfrmCfgPortadoresAutorizadosEmail.fVerificaJaCadastrado(strCodPor : String): Boolean;
 Var
     iRec : Integer;
Begin

  iRec := cdsPortadoresAut.RecNo;
  cdsPortadoresAut.DisableControls;
  Result := False;

  cdsPortadoresAut.First;

  While Not cdsPortadoresAut.Eof Do
  Begin
     If strCodPor = cdsPortadoresAut.FieldbyName('POR_CODPOR').AsString Then
     Begin
        Result := True;
        Break;
     End;
     cdsPortadoresAut.Next;
  End;

  cdsPortadoresAut.RecNo := iRec;
  cdsPortadoresAut.EnableControls;

End;

end.

