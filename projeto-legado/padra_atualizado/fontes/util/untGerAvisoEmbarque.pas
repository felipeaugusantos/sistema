unit untGerAvisoEmbarque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, MaskEditFocus, ExtCtrls, StdCtrls, EditFocus, AppEvnts,
  Menus, Buttons, BitBtnLockedIncrem, Grids, DBGridCitel, DBGrids, DB, ComCtrls, DirectoryEditFocus,
  Uni, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, frxClass,
  frxExportCSVTestabilidade,
  untFrameDirectoryEditFocus;

type
  TfrmGerAvisoEmbarque = class(TfrmPai)
    pnlFundo: TPanel;
    grpDocumento: TGroupBox;
    lbl1: TLabel;
    lbl5: TLabel;
    lblEmpresa: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    rdgGeradas: TRadioGroup;
    rdgCFOP: TRadioGroup;
    lbl3: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lbl2: TLabel;
    lblDesDtaFin: TLabel;
    lblCliFor: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    dbgConsulta: TDBGridCitel;
    pnlBottom: TPanel;
    btnGravar: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnConsultar: TBitBtnLocked;
    dtsConsulta: TDataSource;
    Label1: TLabel;
    pgbProgresso: TProgressBar;
    fraPatExp: TfraDirectoryEditFocus;
    procedure btnConsultarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure dbgConsultaDblClick(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
  private
    qryConsulta: TUniQuery;
    stlSelecionados: TStringList;

    procedure pMarcarSelecionado;
    function fValidaDocumento(strAutInc, strCodCli, strTabGer: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

const
  IND_GERADAS = 0;
  IND_NAO_GERADAS = 1;

  IND_TODOS_CFOP = 0;
  IND_SOMENTE_VENDA = 1;

implementation

uses untSQLRepositorio, untFuncoesSimples, untTAvisoEmbarque, untConsultas, untMemo,
  untTypesSistema, untRadioGroupAvisoEmbarque;

{$R *.dfm}

procedure TfrmGerAvisoEmbarque.btnConsultarClick(Sender: TObject);
  Var
    strEmp,
    strGerada,
    strCfop: String;
begin

  If Not fVerificaCampos Then
    Exit;

  strEmp := IIF(fEmptyStr(edtCodEmp.Text), strEmpAcessoUsuarioLogado, edtCodEmp.Text);
  strGerada := IIF(rdgGeradas.ItemIndex = IND_GERADAS, 'S', 'N');
  strCfop := IIF(rdgCFOP.ItemIndex = IND_TODOS_CFOP, 'T', 'V');

  qryConsulta.Close;
  pSQL(qryConsulta, repFaturamento, 'CONSULTA_DOCS_AVISO_EMBARQUE',
       [strEmp,                          // [0] = CÓDIGO DA EMPRESA
        edtNumDoc.Text,                  // [1] = NÚMERO DOCUMENTO
        edtEspDoc.Text,                  // [2] = ESPÉCIE DO DOCUMENTO
        StrToDateDef(mskDtaIni.Text, 0), // [3] = DATA INICIAL
        StrToDateDef(mskDtaFin.Text, 0), // [4] = DATA FINAL
        edtCodCli.Text,                  // [5] = CÓDIGO DO CLIENTE
        strGerada,                       // [6] = GERADA/NÃO GERADA  (S/N)
        strCfop]);                       // [7] = CFOP - TODOS / SOMENTE VENDA (T/V)
  qryConsulta.Open;

  TFloatField(qryConsulta.FieldByName('VLRCON')).DisplayFormat := '#,##0.00';

  If Not qryConsulta.IsEmpty Then
    pSetFocus(dbgConsulta);
end;

procedure TfrmGerAvisoEmbarque.btnDesmarcaTodosClick(Sender: TObject);
begin
  stlSelecionados.Clear;
  dbgConsulta.Repaint;
end;

procedure TfrmGerAvisoEmbarque.btnGravarClick(Sender: TObject);
  Var
    objAvisoEmbarque: TAvisoEmbarque;
    blnErros: Boolean;
    bmk: TBookmark;
    frmRadioGroupAvisoEmbarque: TfrmRadioGroupAvisoEmbarque;
begin
  If (qryConsulta.IsEmpty) Or (stlSelecionados.Count = 0) Then
  Begin
    pMensagemOk('É necessário selecionar ao menos um documento!');
    Exit;
  End;

  If Not DirectoryExists(fraPatExp.edtDirectory.text) Then
  Begin
    pMensagemOk('Path de exportação não existe!');
    Exit;
  End;

  pCriarFormularios(TfrmRadioGroupAvisoEmbarque, frmRadioGroupAvisoEmbarque);
  objAvisoEmbarque := TAvisoEmbarque.Create;
  blnErros := False;
  qryConsulta.DisableControls;
  bmk := qryConsulta.Bookmark;
  pgbProgresso.Visible := True;
  Try
    if frmRadioGroupAvisoEmbarque.ShowModal <> mrOk then
      Exit;

    qryConsulta.First;
    pgbProgresso.Max := qryConsulta.RecordCount;
    pgbProgresso.Position := 0;
    While Not qryConsulta.Eof Do
    Begin
      pgbProgresso.StepBy(1);
      If stlSelecionados.IndexOf(qryConsulta.FieldByName('AUTINC').AsString) > -1 Then
      Begin
        objAvisoEmbarque.Inicializar;
        objAvisoEmbarque.strCodEmp := qryConsulta.FieldByName('CODEMP').AsString;
        objAvisoEmbarque.strNumDoc := qryConsulta.FieldByName('NUMDOC').AsString;
        objAvisoEmbarque.strEspDoc := qryConsulta.FieldByName('ESPDOC').AsString;
        objAvisoEmbarque.strCodCli := qryConsulta.FieldByName('CODCLI').AsString;
        objAvisoEmbarque.strTabGer := qryConsulta.FieldByName('TABGER').AsString;

        Try
          if frmRadioGroupAvisoEmbarque.rdgAvisoEmbarque.ItemIndex = 0 then
            objAvisoEmbarque.pGerarArquivo(fraPatExp.edtDirectory.text)
          Else
            objAvisoEmbarque.pGerarXmlB2B(fraPatExp.edtDirectory.text, qryConsulta.FieldByName('AUTINC').AsString);
        Except
          On E: Exception Do
          Begin
            blnErros := True;
            If fMensagem('', E.Message, ['&Continuar', '&Abortar']) = 2 Then
              Break;
          End;
        End;
      End;

      qryConsulta.Next;
    End;

    stlSelecionados.Clear;

    If blnErros Then
      pMensagemOk('Exportação realizada com erros!')
    Else
      pMensagemOk('Exportação realizada com sucesso!');
  Finally
    pgbProgresso.Visible := False;
    qryConsulta.Bookmark := bmk;
    qryConsulta.EnableControls;
    dbgConsulta.Repaint;
    objAvisoEmbarque.Free;
    pFreeAndNil(frmRadioGroupAvisoEmbarque);
  End;
end;

procedure TfrmGerAvisoEmbarque.btnMarcaTodosClick(Sender: TObject);
begin
  stlSelecionados.Clear;

  qryConsulta.DisableControls;
  qryConsulta.First;

  While Not qryConsulta.Eof Do
  Begin
    stlSelecionados.Add(qryConsulta.FieldByName('AUTINC').AsString);
    qryConsulta.Next;
  End;

  qryConsulta.First;
  qryConsulta.EnableControls;
end;

procedure TfrmGerAvisoEmbarque.dbgConsultaDblClick(Sender: TObject);
begin
  pMarcarSelecionado;
end;

procedure TfrmGerAvisoEmbarque.dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  If stlSelecionados.IndexOf(qryConsulta.FieldByName('AUTINC').AsString) > -1 Then
  Begin
    dbgConsulta.Canvas.Brush.Color := clBlue;
    dbgConsulta.Canvas.Font.Color := clWhite;
  End;

  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmGerAvisoEmbarque.dbgConsultaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN Then
    pMarcarSelecionado;
end;

procedure TfrmGerAvisoEmbarque.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodCli) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerAvisoEmbarque.FormActivate(Sender: TObject);
begin
  pSetFocus(edtNumDoc);
end;

procedure TfrmGerAvisoEmbarque.FormCreate(Sender: TObject);
begin
  inherited;
  
  qryConsulta := fCriaQuery;
  dtsConsulta.DataSet := qryConsulta;
  
  stlSelecionados := TStringList.Create;

  edtNumDoc.MaxLength := fTamDocCadRec();
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
end;

procedure TfrmGerAvisoEmbarque.FormDestroy(Sender: TObject);
begin
  qryConsulta.Free;
  stlSelecionados.Free;

  inherited;
end;

procedure TfrmGerAvisoEmbarque.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: If (ActiveControl is TRadioButton) Then
                 SelectNext(ActiveControl, True, True);
    VK_F10: btnGravar.Click;
    VK_F6: btnMarcaTodos.Click;
    VK_F7: btnDesmarcaTodos.Click;
  End;
end;

procedure TfrmGerAvisoEmbarque.FormShow(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := VS_strCodEmp;
  fraPatExp.edtDirectory.text := ExtractFilePath(Application.ExeName);
end;

function TfrmGerAvisoEmbarque.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    strMsg: String;
begin
  //#Asimov# inherited fValidaCampos
  If not (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Exit(False);
  //
  Result := True;

  If Sender = edtEspDoc Then
  Begin
    If Not fEmptyStr(edtEspDoc.Text) And (Pos(edtEspDoc.Text, 'NF_EL_IF_IV_') = 0) Then
      strMsg := 'Somente permitido espécies "NF", "EL", "IF" e "IV"!';
  End

  Else If Sender = edtCodEmp Then
  Begin
    If (Not fEmptyStr(edtCodEmp.Text)) And (Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) = 0) Then
      strMsg := 'Usuário não tem acesso a essa empresa!';
  End

  Else If Sender = mskDtaIni Then
  Begin
    If (Not fEmptyStr(mskDtaIni.Text, True)) And (StrToDateDef(mskDtaIni.Text, 0) = 0) Then
      strMsg := 'Data inicial inválida!';
  End

  Else If Sender = mskDtaFin Then
  Begin
    If (Not fEmptyStr(mskDtaFin.Text, True)) And (StrToDateDef(mskDtaFin.Text, 0) = 0) Then
      strMsg := 'Data final inválida!';
  End

  Else If Sender = edtCodCli Then
  Begin
    If fEmptyStr(edtCodCli.Text) Then
      edtNomCli.Clear
    Else
    Begin
      edtNomCli.Text := fRetNomCliente(edtCodCli.Text);

      If fEmptyStr(edtNomCli.Text) Then
        strMsg := 'Cliente não encontrado!';
    End
  End;

  If Not fEmptyStr(strMsg) Then
  Begin
    Result := False;
    fMensagem('', strMsg, ['&O k']);
    pSetFocus(Sender);
  End;
end;

function TfrmGerAvisoEmbarque.fValidaDocumento(strAutInc, strCodCli, strTabGer: String): Boolean;
  Var
    qryValida: TUniQuery;
    strItensSemCliPro,
    strTabDet: String;
begin
  Result := False;

  If Not fCfgSis('CLIPRO', varBoolean) Then
  Begin
    Result := True;
    Exit;
  End;

  qryValida := fCriaQuery;
  strItensSemCliPro := '';

  Try
    // Obtém itens da nota que não possuem CLIPRO
    If strTabGer = 'MOVGER' Then
      strTabDet := 'MOVDET'
    Else
      strTabDet := 'NOTDET';
      
    pSQL(qryValida, repFaturamento, 'ITENS_SEM_CLIPRO', [strAutInc, strTabDet]);
    qryValida.Open;

    While Not qryValida.Eof Do
    Begin
      strItensSemCliPro := strItensSemCliPro + qryValida.FieldByName('CODITE').AsString + '-' + qryValida.FieldByName('DESITE').AsString + #13#10;

      qryValida.Next;
    End;

    // Se houver itens sem CLIPRO não pode exportar aviso
    If Not fEmptyStr(strItensSemCliPro) Then
    Begin
      TfrmMemo.pShowMessage('Os seguintes itens da nota não possuem "Relacionamento Cliente-Produto", favor corrigir (Cadastro de Clientes / Aba Relacionamento Cliente-Produto):' + #13#10
                          + strItensSemCliPro);
      Exit;
    End;

    // Verifica se o cliente possui FABDES (Fábrica de Destino) se não tiver não pode exportar.
    qryValida.Close;
    pSQL(qryValida, repFaturamento, 'VALIDA_CLIENTE_POSSUI_FABDES', [strCodCli]);
    qryValida.Open;

    If qryValida.FieldByName('QTDREGISTRO').AsInteger > 0 Then
    Begin
      pMensagemOK('Cliente da nota não possui Identificação da Fábrica de Destino, favor corrigir!');
      Exit;
    End;

    Result := True;
  Finally
    qryValida.Free;
  End;
end;

procedure TfrmGerAvisoEmbarque.pMarcarSelecionado;
begin
  If qryConsulta.IsEmpty Then
    Exit;

  If stlSelecionados.IndexOf(qryConsulta.FieldByName('AUTINC').AsString) = -1 Then
  Begin
    If fValidaDocumento(qryConsulta.FieldByName('AUTINC').AsString,
                        qryConsulta.FieldByName('CODCLI').AsString,
                        qryConsulta.FieldByName('TABGER').AsString) Then
      stlSelecionados.Add(qryConsulta.FieldByName('AUTINC').AsString);
  End
  Else
    stlSelecionados.Delete(stlSelecionados.IndexOf(qryConsulta.FieldByName('AUTINC').AsString));

  dbgConsulta.Repaint;
end;

end.
