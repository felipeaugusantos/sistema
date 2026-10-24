unit untBaixaEntregadores;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, cxHint, DB, Grids, DBGridCitel, DBGrids,
  EditFocus, StdCtrls, ExtCtrls, AppEvnts, Menus, ComCtrls, Buttons, Uni, untTypesSistema,
  cxControls, cxContainer, cxEdit, cxProgressBar, BitBtnLockedIncrem, dxScreenTip,
  cxClasses, dxCustomHint, untBaixaComEntreg, frxClass, frxExportCSVTestabilidade;

type
  TfrmBaixaEntregadores = class(TfrmPaiSimples)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    pnlFundo: TPanel;
    dtsComEng: TDataSource;
    dtsComEnd: TDataSource;
    pnlConfirma: TPanel;
    btnGravar: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    BitBtn1: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    HintControler: TcxHintStyleController;
    btnDocPen: TBitBtnLocked;
    pnlDocBai: TPanel;
    lblDadDoc: TLabel;
    lbl5: TLabel;
    btnMarcar: TBitBtnLocked;
    pnlGeral: TPanel;
    lblEntregador: TLabel;
    lblEntreg: TLabel;
    lblDocEnt: TLabel;
    edtCodMot: TEditFocus;
    dbgEntregas: TDBGridCitel;
    dbgDocumentos: TDBGridCitel;
    bvlTopo: TBevel;
    shp1: TShape;
    lbl6: TLabel;
    shp2: TShape;
    lbl7: TLabel;
    edtNomMot: TEditFocus;
    pnlDocume: TPanel;
    pnlCodBar: TPanel;
    lbl2: TLabel;
    edtNumDoc: TEditFocus;
    lbl3: TLabel;
    edtEspDoc: TEditFocus;
    lbl4: TLabel;
    edtCodEmp: TEditFocus;
    Label1: TLabel;
    edtCodBar: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure edtCodMotKeyPress(Sender: TObject; var Key: Char);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtCodMotEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgDocumentosDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgEntregasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure edtEspDocEnter(Sender: TObject);
    procedure edtEspDocExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDocPenClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    objBaixaEntrega : TBaixaEnt;
    blnPodeFechar   : Boolean;
    strOpcEnt       : String;
    procedure pLimpaCamposDoc;
    procedure pAjustaCampoEntregador;
    procedure pAjustaCampoDocumento;
    procedure pFocaCampoDocumento;
  public
    { Public declarations }
  protected
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; Override;
    procedure pEscapePressed; override;    
  end;


implementation

uses SysUtils, Graphics, strUtils, untPai, untFuncoesSimples, untConsultas;

{$R *.dfm}

function TfrmBaixaEntregadores.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
Var
  strCodTmp: String;
begin

  Result := True;

  If (sender = edtCodMot) Then
  Begin
    If fEmptyStr(edtCodMot.Text) Then
    Begin
      fMensagem('', strOpcEnt + ' do entregador deve ser informado !', ['&O K']);
      Result := False;
    End
    Else
    Begin
      If (objBaixaEntrega.getTipEnt = tebBarras) Then
      Begin
        strCodTmp := fRetCodMotoristaBarras(edtCodMot.Text);
        edtNomMot.Text := fRetNomeMotorista(strCodTmp);
        If fEmptyStr(edtNomMot.Text) Then
        Begin
          fMensagem('', strOpcEnt + ' do entregador está incorreto!', ['&O K']);
          Result := False;
        End
        Else
          objBaixaEntrega.strCodEnt := strCodTmp;
      End
      Else If (objBaixaEntrega.getTipEnt = tebSenha) Then
      Begin
        strCodTmp := fRetCodMotoristaSenha(edtCodMot.Text);
        edtNomMot.Text := fRetNomeMotorista(strCodTmp);
        If fEmptyStr(edtNomMot.Text) Then
        Begin
          fMensagem('', strOpcEnt + ' do entregador está incorreta!', ['&O K']);
          Result := False;
        End
        Else
          objBaixaEntrega.strCodEnt := strCodTmp;
      End
      Else
      Begin
        edtNomMot.Text := fRetNomeMotorista(edtCodMot.Text);
        If fEmptyStr(edtNomMot.Text) Then
        Begin
          fMensagem('', strOpcEnt + ' do entregador está incorreto!', ['&O K']);
          Result := False;
        End
        Else
          objBaixaEntrega.strCodEnt := edtCodMot.Text;
      End;

      If (Result) Then
      Begin
        Screen.Cursor := crHourGlass;
        pnlInfo.Caption := 'Aguarde...Carregando documentos!';
        Application.ProcessMessages;

        If Not objBaixaEntrega.fCarregaEntregasPendentes Then
        Begin
          fMensagem('','Nenhuma entrega pendente foi encontrada !', ['&O K']);
          Result := False;
        End
        Else
        Begin
          dtsComEng.DataSet := objBaixaEntrega.cdsComEng;
          dtsComEnd.DataSet := objBaixaEntrega.cdsComEnd;

          pFocaCampoDocumento;
          blnMudarFoco := False;
        End;

        pnlInfo.Caption := '';
        Screen.Cursor   := crDefault;
      End;
    End;
  End;

  If (objBaixaEntrega.fTipoBaixa = tpbceCega) Then
  Begin
    If (objBaixaEntrega.getInsDoc <> idoBarras) And (Sender = edtNumDoc) Then
    Begin
      If (fEmptyStr(edtNumDoc.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O Número do Documento deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End
    Else If (objBaixaEntrega.getInsDoc <> idoBarras) And (Sender = edtEspDoc) Then
    Begin
      If (fEmptyStr(edtEspDoc.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Espécie do documento deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (Pos(edtEspDoc.Text, AnsiReplaceStr(edtEspDoc.Hint, ' ','')) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Espécie de documento não permitida!', ['&O k']);
        Result := False;
      End;
    End
    Else If (objBaixaEntrega.getInsDoc <> idoBarras) And (Sender = edtCodEmp) Then
    Begin
      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O Código da Empresa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (fEmptyStr(fRetNomeEmpresa(edtCodEmp.Text))) Then
        Begin
          fMensagem('ATENÇÃO!','Essa Empresa não está cadastrada!', ['&O k']);
          Result := False;
        End
        Else If (Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Operador não possui permissão de acesso para a Empresa ' + edtCodEmp.Text, ['&O k']);
          Result := False;
        End;
      End;
    End
    Else If (objBaixaEntrega.getInsDoc = idoBarras) And (Sender = edtCodBar) Then
    Begin
      If (fEmptyStr(edtCodBar.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O Código de Barras do Documento deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (Length(edtCodBar.Text) <> 18) And (Length(edtCodBar.Text) <> 44) Then
      Begin
        fMensagem('ATENÇÃO!','O Código de Barras informado é inválido!', ['&O k']);
        pLimpaCamposDoc;
        Result := False;
      End
      Else
      Begin
        btnMarcar.Click;
        blnMudarFoco := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmBaixaEntregadores.FormCreate(Sender: TObject);
begin
  inherited;
  objBaixaEntrega := TBaixaEnt.Create(Self);
end;

procedure TfrmBaixaEntregadores.edtCodMotKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrMot: TConsultasArray;
begin
  If (objBaixaEntrega.getTipEnt in [tebSenha, tebBarras]) Then
    Exit;

  {*******************************}
  {* NOVA CONSULTA DE MOTORISTAS *}
  {****************************RV*}
  If fPesqMotorista(Self, edtCodMot, edtNomMot, Nil, Key, arrMot) Then
  Begin
    fValidaCampos(edtCodMot, True)
  End;
end;

procedure TfrmBaixaEntregadores.btnDesmarcaTodosClick(Sender: TObject);
  Var
    intRecNo: Integer;
begin
  inherited;
  If (btnDesmarcaTodos.Visible) Then
  Begin
    If Assigned(objBaixaEntrega.cdsComEng) Then
    Begin
      objBaixaEntrega.cdsComEng.First;
      While Not objBaixaEntrega.cdsComEng.Eof Do
      Begin
        intRecNo := objBaixaEntrega.cdsComEng.RecNo;
        objBaixaEntrega.pMarcaTodosDocumentosEntregaPeloPai(objBaixaEntrega.cdsComEng.FieldByName('AUTOINCREM').AsString, 'N');
        objBaixaEntrega.cdsComEng.RecNo := intRecNo;
        objBaixaEntrega.cdsComEng.Next;
      End;
    End;
  End;
end;

procedure TfrmBaixaEntregadores.btnMarcaTodosClick(Sender: TObject);
  Var
    intRecNo: Integer;
begin
  inherited;
  If (btnMarcaTodos.Visible) Then
  Begin
    If Assigned(objBaixaEntrega.cdsComEng) Then
    Begin
      objBaixaEntrega.cdsComEng.First;
      While Not objBaixaEntrega.cdsComEng.Eof Do
      Begin
        intRecNo := objBaixaEntrega.cdsComEng.RecNo;
        objBaixaEntrega.pMarcaTodosDocumentosEntregaPeloPai(objBaixaEntrega.cdsComEng.FieldByName('AUTOINCREM').AsString, 'S');
        objBaixaEntrega.cdsComEng.RecNo := intRecNo;
        objBaixaEntrega.cdsComEng.Next;
      End;
    End;
  End;
end;

procedure TfrmBaixaEntregadores.btnGravarClick(Sender: TObject);
begin
  inherited;
  With objBaixaEntrega Do
  Begin
    If (stlBaiEng.Count = 0) And (stlBaiEnd.Count = 0) Then
    Begin
      fMensagem('', 'Nenhum registro para baixar !', ['&O K']);
    End
    Else If fMensagem('','Confirma a baixa ?',['','']) = 1 Then
    Begin
      If (fBaixarEntrega) Then
        pSetFocus(edtCodMot);
    End;
  End;
end;

procedure TfrmBaixaEntregadores.btnCancelaClick(Sender: TObject);
begin

  inherited;

  If (Assigned(objBaixaEntrega.cdsComEng)) And (Not objBaixaEntrega.cdsComEng.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!','Deseja realmente abandonar a baixa?', ['&S i m', '&N ã o'], 2) = 2) Then
    Begin
      pFocaCampoDocumento;
      Exit;
    End;
  End;

  objBaixaEntrega.blnDocPen := False;
  objBaixaEntrega.pfecharConsulta;
  edtCodMot.Clear;
  edtNomMot.Clear;
  pSetFocus(edtCodMot);

  lblEntreg.Caption := 'Entregas';
  lblDocEnt.Caption := 'Documentos da Entrega';

  btnGravar.Enabled := True;

  If (objBaixaEntrega.fTipoBaixa = tpbceCega) And (Not pnlDocBai.Visible) Then
  Begin
    pnlDocBai.Visible := True;
  End;

end;

procedure TfrmBaixaEntregadores.edtCodMotEnter(Sender: TObject);
begin
  inherited;
  btnCancela.Click;
  SetForegroundWindow(Self.Handle);
  pSetFocus(edtCodMot);
end;

procedure TfrmBaixaEntregadores.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    strAutPai,
    strAutFil: String;
begin
  inherited;

  Case Key Of
    VK_F10    : If (btnGravar.Enabled) Then
                  btnGravar.Click
                Else
                  pSetFocus(dbgEntregas);

    VK_F5     : If (btnDocPen.Visible) Then
                  btnDocPen.Click;

    VK_F6     : btnMarcaTodos.Click;

    VK_F7     : btnDesmarcaTodos.Click;

    VK_ESCAPE : If ((ActiveControl) = edtCodMot) Then
                Begin
                  blnPodeFechar := True;
                  Close;
                End
                Else
                Begin
                  If (objBaixaEntrega.fTipoBaixa = tpbceRapida) Then
                    btnCancela.Click
                  Else
                  Begin
                    If objBaixaEntrega.blnDocPen Then
                      btnDocPen.Click
                    Else
                      btnCancela.Click
                  End;
                End;

    VK_RETURN : If (objBaixaEntrega.fTipoBaixa = tpbceRapida) Then
                Begin
                  If ((ActiveControl) = dbgEntregas) And Assigned(objBaixaEntrega.cdsComEng) Then
                  Begin
                    If Not objBaixaEntrega.cdsComEng.IsEmpty Then
                    Begin
                      strAutPai := objBaixaEntrega.cdsComEng.FieldByName('AUTOINCREM').AsString;
                      strAutFil := objBaixaEntrega.cdsComEnd.FieldByName('AUTOINCREM').AsString;

                      objBaixaEntrega.pMarcaTodosDocumentosEntregaPeloPai(strAutPai,
                                                                          IIF(objBaixaEntrega.cdsComEng.FieldByName('MARCAD').AsString<>'S','S','N'));

                      objBaixaEntrega.cdsComEng.Locate('AUTOINCREM', strAutPai, []);
                      objBaixaEntrega.cdsComEnd.Locate('AUTOINCREM', strAutFil, []);
                    End
                  End

                  Else If ((ActiveControl) = dbgDocumentos) And Assigned(objBaixaEntrega.cdsComEnd) Then
                  Begin
                    If Not objBaixaEntrega.cdsComEnd.IsEmpty Then
                    Begin
                      strAutFil := objBaixaEntrega.cdsComEnd.FieldByName('AUTOINCREM').AsString;
                      strAutPai := objBaixaEntrega.cdsComEng.FieldByName('AUTOINCREM').AsString;

                      objBaixaEntrega.fMarcaDocumento(objBaixaEntrega.cdsComEnd.FieldByName('END_NUMDOC').AsString,
                                                      objBaixaEntrega.cdsComEnd.FieldByName('END_ESPDOC').AsString,
                                                      objBaixaEntrega.cdsComEnd.FieldByName('END_EMPDOC').AsString,
                                                      IIF(objBaixaEntrega.cdsComEnd.FieldByName('MARCAD').AsString<>'S','S','N'));

                      objBaixaEntrega.cdsComEng.Locate('AUTOINCREM', strAutPai, []);
                      objBaixaEntrega.cdsComEnd.Locate('AUTOINCREM', strAutFil, []);
                    End;
                  End;
                End;
  End;

end;

procedure TfrmBaixaEntregadores.dbgDocumentosDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If (objBaixaEntrega.cdsComEnd <> Nil) And
     (objBaixaEntrega.cdsComEnd.RecordCount > 0) Then
  Begin
    If (objBaixaEntrega.fTipoBaixa = tpbceRapida) Then
    Begin
      If Column.Field.DataSet.FieldByName('MARCAD').AsString = 'S' Then
      Begin
        dbgDocumentos.Canvas.Font.Color := clBlue;
        dbgDocumentos.DefaultDrawColumnCell(Rect,DataCol,Column,State);
      End
    End

    Else If (objBaixaEntrega.cdsComEnd.RecNo Mod 2) = 0 Then
    Begin
      dbgDocumentos.Canvas.Brush.Color := fCfgSis('CORZEB');
      dbgDocumentos.Canvas.FillRect(Rect);
      dbgDocumentos.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    End;
  End;
end;

procedure TfrmBaixaEntregadores.dbgEntregasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If (objBaixaEntrega.cdsComEng <> Nil) And
     (objBaixaEntrega.cdsComEng.RecordCount > 0) Then
  Begin
    If Column.Field.DataSet.FieldByName('MARCAD').AsString = 'S' Then
    Begin
      dbgEntregas.Canvas.Font.Color := clBlue;
      dbgEntregas.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    End
    Else If Column.Field.DataSet.FieldByName('MARCAD').AsString = 'P' Then
    Begin
      dbgEntregas.Canvas.Font.Color := clRed;
      dbgEntregas.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    End;
  End;
end;

procedure TfrmBaixaEntregadores.FormShow(Sender: TObject);
begin
  inherited;

  edtCodEmp.Text    := VS_strCodEmp;
  blnPodeFechar     := False;

  If fCfgSis('MATCON', varBoolean) Then
    edtEspDoc.Hint := edtEspDoc.Hint + ' - RQ';

  btnDocPen.Visible := False;
  pAjustaCampoEntregador;
  pAjustaCampoDocumento;

  If objBaixaEntrega.fTipoBaixa = tpbceCega Then
  Begin
    btnMarcaTodos.Visible := False;
    btnDesmarcaTodos.Visible := False;

    pnlDocBai.Visible := True;

    If (fVerificaAcessoSistema('PENENT')) Then
       btnDocPen.Visible := True;

    fOrganizaControlesConformePassagemArgumentos([btnGravar, btnCancela, btnDocPen]);
  End
  Else
  Begin
    btnMarcaTodos.Visible := True;
    btnDesmarcaTodos.Visible := True;

    pnlDocBai.Visible := False;

    fOrganizaControlesConformePassagemArgumentos([btnGravar, btnMarcaTodos, btnDesmarcaTodos, btnCancela]);
  End;

  {************************************************************************************}
  { SEMPRE DEIXE ESSSA CHAMADA POR ÚLTIMO E COLOQUE NOVOS ELEMENTOS DENTRO DE pnlFundo }
  { EM "SUB-PAINEIS" COM ALIGN alTop, COMO OS DEMAIS                                   }
  {*********************************************************************************VA*}
  Self.ClientHeight := fRetornaSomaAlturaDosPaineisVisiveisEm(pnlFundo) + pnlInfo.Height;
end;

procedure TfrmBaixaEntregadores.btnMarcarClick(Sender: TObject);
Var
  strNumDoc: String;
  strEspDoc: String;
  strCodEmp: String;
begin
  inherited;

  If (objBaixaEntrega.getInsDoc = idoBarras) Then
  Begin
    If (Not fValidaCampos(edtCodBar, True)) Then
      Exit;
  End
  Else
  Begin
    If (Not fValidaCampos(edtNumDoc, True)) Or
       (Not fValidaCampos(edtEspDoc, True)) Or
       (Not fValidaCampos(edtCodEmp, True)) Then
    Begin
      Exit;
    End;
  End;

  If (Not Assigned(objBaixaEntrega.cdsComEnd)) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário carregar o Entregador antes!', ['&O k']);
    pSetFocus(edtCodMot);
    Exit;
  End;

  objBaixaEntrega.setChaAce('');
  strNumDoc := '';
  strEspDoc := '';
  strCodEmp := '';

  If (objBaixaEntrega.getInsDoc = idoBarras) Then
  Begin
    If (Length(edtCodBar.Text) = 44) Then
      pConverteCodigoBarrasChaveAcesso(edtCodBar.Text, strNumDoc, strEspDoc, strCodEmp)
    Else
    Begin
      pConverteCodigoBarrasDocumento(edtCodBar.Text, strNumDoc, strEspDoc, strCodEmp);

      If (fEmptyStr(strEspDoc)) Then
      Begin
        fMensagem('', 'Não foi possível identificar a Espécie do Documento!', ['&O k']);
        pLimpaCamposDoc;
        Exit;
      End;
    End;
  End
  Else
  Begin
    strNumDoc := edtNumDoc.Text;
    strEspDoc := edtEspDoc.Text;
    strCodEmp := edtCodEmp.Text;
  End;

  If (Not objBaixaEntrega.fMarcaDocumento(strNumDoc, strEspDoc, strCodEmp)) Then
  Begin
    If (objBaixaEntrega.getInsDoc = idoBarras) And (Length(edtCodBar.Text) = 44) Then
      fMensagem('ATENÇÃO!', 'A chave de acesso ' + edtCodBar.Text + ' não foi encontrada para baixa.', ['&O k'])
    Else
      fMensagem('ATENÇÃO!', 'O documento ' + strNumDoc + '-' + strEspDoc + '-' + strCodEmp + ' não foi encontrado para baixa.', ['&O k']);

    If (objBaixaEntrega.getInsDoc = idoBarras) Then
      pLImpaCamposDoc;

    pFocaCampoDocumento;
  End
  Else
    pLimpaCamposDoc;
end;

procedure TfrmBaixaEntregadores.pLimpaCamposDoc;
begin
  edtCodBar.Clear;
  edtNumDoc.Clear;
  edtEspDoc.Clear;
  edtCodEmp.Text := VS_strCodEmp;
  pFocaCampoDocumento;
end;

procedure TfrmBaixaEntregadores.edtEspDocEnter(Sender: TObject);

  function fGetXYControle(cmp: TComponent; XY:Char): Integer;
   Var
    cmpAux: TComponent;
  begin
    Result := IIF(XY='Y',TControl(cmp).Top-TControl(cmp).Height, TControl(cmp).Left+TControl(cmp).Width);
    cmpAux := cmp.GetParentComponent;
    While (cmpAux <> Nil) Do
    Begin
      Result := Result + IIF(XY='Y',TControl(cmpAux).Top, TControl(cmpAux).Left);
      cmpAux := cmpAux.GetParentComponent;
    End
  End;

begin
  inherited;
  HintControler.ShowHint(fGetXYControle(edtEspDoc, 'X'),
                         fGetXYControle(edtEspDoc, 'Y'), 'Espécies permitidas:', edtEspDoc.Hint);
end;

procedure TfrmBaixaEntregadores.edtEspDocExit(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfrmBaixaEntregadores.pAjustaCampoDocumento;
begin
  pnlCodBar.Visible := (objBaixaEntrega.GetInsDoc = idoBarras);
  pnlDocume.Visible := (Not pnlCodBar.Visible);

  If (objBaixaEntrega.GetInsDoc = idoBarras) Then
  Begin
    lblDadDoc.Caption := 'Informe o Código de Barras do Documento para marcá-lo para baixa';
  End
  Else
  Begin
    lblDadDoc.Caption := 'Informe os Dados do Documento para marcá-lo para baixa';
  End;
end;

procedure TfrmBaixaEntregadores.pAjustaCampoEntregador;
begin
  If (objBaixaEntrega.getTipEnt = tebBarras) Then
  Begin
    edtCodMot.Width        := 119;
    edtCodMot.MaxLength    := 13;
    edtCodMot.TamCampo     := 0;
    edtCodMot.CompZeros    := False;
    edtCodMot.PasswordChar := '*';
    edtCodMot.TipoTexto    := ttAlfanumerico;

    edtNomMot.Left         := 195;
    edtNomMot.Width        := pnlGeral.Width-edtNomMot.Left-12;

    strOpcEnt              := 'Código de Barras';
  End
  Else If (objBaixaEntrega.getTipEnt = tebSenha) Then
  Begin
    edtCodMot.Width        := 69;
    edtCodMot.MaxLength    := 10;
    edtCodMot.TamCampo     := 0;
    edtCodMot.CompZeros    := False;
    edtCodMot.PasswordChar := '*';
    edtCodMot.TipoTexto    := ttAlfanumerico;

    edtNomMot.Left         := 145;
    edtNomMot.Width        := pnlGeral.Width-edtNomMot.Left-12;
    strOpcEnt              := 'Senha';
  End
  Else
  Begin
    edtCodMot.Width        := 62;
    edtCodMot.MaxLength    := 5;
    edtCodMot.TamCampo     := 5;
    edtCodMot.CompZeros    := True;
    edtCodMot.PasswordChar := #0;
    edtCodMot.TipoTexto    := ttNumerico;

    edtNomMot.Left         := 138;
    edtNomMot.Width        := pnlGeral.Width-edtNomMot.Left-12;
    strOpcEnt              := 'Código';
  End;
end;

procedure TfrmBaixaEntregadores.pEscapePressed;
begin
//
end;

procedure TfrmBaixaEntregadores.pFocaCampoDocumento;
begin
  If (objBaixaEntrega.fTipoBaixa = tpbceCega) Then
  Begin
    If (objBaixaEntrega.getInsDoc = idoDocumento) Then
      pSetFocus(edtNumDoc)
    Else
      pSetFocus(edtCodBar);
  End
  Else
    pSetFocus(dbgEntregas);

  SetForegroundWindow(Self.Handle);
end;

procedure TfrmBaixaEntregadores.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodMot);
end;

procedure TfrmBaixaEntregadores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  blnPodeFechar := (Not Assigned(objBaixaEntrega.cdsComEng)) Or (objBaixaEntrega.cdsComEng.IsEmpty);

  If (Not blnPodeFechar) Then
  Begin
    fMensagem('ATENÇÃO!', 'Você deve concluir ou cancelar a operação de baixa antes de fechar a tela!', ['&O k']);
    Action := caNone;
  End
  Else
  Begin
    If Assigned(objBaixaEntrega) Then
     FreeAndNil(objBaixaEntrega);

    inherited;
  End;
end;

procedure TfrmBaixaEntregadores.btnDocPenClick(Sender: TObject);
Var
  intPosAtu: Integer;
begin
  inherited;

  If (Not Assigned(objBaixaEntrega.cdsComEng)) Or (objBaixaEntrega.cdsComEng.IsEmpty) Then
    Exit
  Else
  Begin
    If (objBaixaEntrega.blnDocPen) Then
    Begin
      btnGravar.Enabled := True;
      objBaixaEntrega.blnDocPen := False;
      pSetFocus(dbgEntregas);
      lblDocEnt.Caption := 'Documentos Pendentes';
      pnlDocBai.Visible := True;
      pFocaCampoDocumento;
    End
    Else
    Begin
      btnGravar.Enabled := False;
      objBaixaEntrega.blnDocPen := True;
      pSetFocus(dbgEntregas);
      lblDocEnt.Caption := 'Documentos da Entrega';
      pnlDocBai.Visible := False;
    End;

    With objBaixaEntrega.cdsComEng Do
    Begin
      DisableControls;
      intPosAtu := RecNo;
      First;
      RecNo := intPosAtu;
      EnableControls;
    End;

  End;

end;

end.
