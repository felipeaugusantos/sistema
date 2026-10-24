unit untCadComEntregadores;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, DBCtrls, DBEditFocus, Grids, DBGridCitel, DBGrids, EditFocus, DB, Uni,
  untComEntregadores, cxHint, untFuncoesSimples, BitBtnLockedIncrem, dxScreenTip,
  cxClasses, dxCustomHint, Mask, frxClass, frxExportCSVTestabilidade, Variants,untTypesSistema, frxBarCode,
  untDigCadComEntregadores, DBMemoFocus;

type
  TfrmCadComEntregadores = class(TfrmPaiCad)
    pnlFundo: TPanel;
    bvlTopo: TBevel;
    dbeProEnt: TDBEditFocus;
    lblProEnt: TLabel;
    lblEntregador: TLabel;
    bvlDocumentos: TBevel;
    dbgDocumentos: TDBGridCitel;
    dtsComEng: TDataSource;
    dtsComEnd: TDataSource;
    HintControler: TcxHintStyleController;
    lblBaixada: TLabel;
    dbePlaVei: TDBEditFocus;
    edtDesVei: TEditFocus;
    Label2: TLabel;
    edtSenMot: TEditFocus;
    edtNomMot: TEditFocus;
    lblIteExp: TLabel;
    shpIteExp: TShape;
    frxReport1: TfrxReport;
    pnlDocume: TPanel;
    lblDocumento: TLabel;
    edtDocume: TEditFocus;
    lblEspecie: TLabel;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtEspDoc: TEditFocus;
    pnlCidade: TPanel;
    Label1: TLabel;
    edtCodCidade: TEditFocus;
    edtDesCidade: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    pnlCodBar: TPanel;
    Label3: TLabel;
    edtCodBar: TEditFocus;
    Label4: TLabel;
    edtNumAju: TDBEditFocus;
    dbeObserv: TDBMemoFocus;
    Label5: TLabel;
    bntEntregas: TBitBtnLocked;
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure dbgDocumentosDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtEspDocEnter(Sender: TObject);
    procedure edtEspDocExit(Sender: TObject);
    procedure edtEspDocKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure dbePlaVeiKeyPress(Sender: TObject; var Key: Char);
    procedure edtSenMotKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bntEntregasClick(Sender: TObject);
  private
    objComEnt: TComEnt;
    dicEntUrg: TDicionario;
    procedure pLimpaDados(blnSetFocus: Boolean = TRUE);
    procedure pLimpaDadosDocumento;
    procedure pBaixada;
    function  fDadosMotorista(strCodMot: String): Boolean;
    procedure pAjustaTela;
    procedure pAjustaCampoEntregador;
    procedure pAjustaCampoDocumento;
    procedure pFocaCampoDocumento;
    function  fSetaDadosDocumentoCodigoBarras: Boolean;
    procedure pControlaCampoCidade(strEspDoc: String);
    function  fRetNumeroDocumento: String;
    function  fRetEspecieDocumento: String;
    function  fRetCodigoEmpresa: String;
    function  fPodeInserir: Boolean;
    function  fRetNumeroDocumentoCodigoBarras: String;
    function  fRetEspecieDocumentoCodigoBarras: String;
    function  fRetEmpresaDocumentoCodigoBarras: String;
    function  fRetornaTipoDeRelatorio(const frmDigCadComEntregadores: TfrmDigCadComEntregadores): Integer;
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; Override;
  end;

implementation

uses SysUtils, Graphics, StrUtils, untPai, untConstantes,
  untConsultas, untFatMotEntregas, UniDataSetProvider;

{$R *.dfm}

procedure TfrmCadComEntregadores.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadComEntregadores.fDadosMotorista(strCodMot: String): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  Try
    Result := False;
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT                 ';
    strSQL := strSQL + '  MOT_CODMOT,          ';
    strSQL := strSQL + '  MOT_PLAVEI           ';
    strSQL := strSQL + 'FROM                   ';
    strSQL := strSQL + '  CADMOT               ';
    strSQL := strSQL + 'WHERE                  ';

    If (objComEnt.GetTipEnt = tenCodigo) Then
      strSQL := strSQL + '  MOT_CODMOT = :CODIGO '
    Else If (objComEnt.GetTipEnt = tenSenha) Then
      strSQL := strSQL + '  BINARY MOT_SENMOT = :CODIGO '
    Else
      strSQL := strSQL + '  MOT_CODBAR = :CODIGO ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (objComEnt.GetTipEnt = tenCodigo) Then
        ParamByName('CODIGO').AsString := strCodMot
      Else If (objComEnt.GetTipEnt = tenSenha) Then
        ParamByName('CODIGO').AsString := fCrypt(strCodMot)
      Else
        ParamByName('CODIGO').AsString := strCodMot;

      Open;

      If (Not IsEmpty) Then
      Begin
        objComEnt.strCodEnt := FieldByName('MOT_CODMOT').AsString;
        objComEnt.strPlaVei := FieldByName('MOT_PLAVEI').AsString;
      End;

      Result := (Not IsEmpty);

      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadComEntregadores.pFocaCampoDocumento;
begin
  If (objComEnt.GetInsDoc = idoBarras) Then
    pSetFocus(edtCodBar)
  Else
    pSetFocus(edtDocume);
End;

procedure TfrmCadComEntregadores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  if Action <> caNone then
  begin
    FreeAndNil(objComEnt);
    FreeAndNil(dicEntUrg);
  end;
end;

procedure TfrmCadComEntregadores.FormCreate(Sender: TObject);
begin
  inherited;
  If fCfgSis('MATCON', varBoolean) Then
    edtEspDoc.Hint := edtEspDoc.Hint + ' - RQ';

  objComEnt := TComEnt.Create;
  dicEntUrg := TDicionario.Create;

  dtsComEng.DataSet := objComEnt.qryComEng;
  dtsComEnd.DataSet := objComEnt.cdsComEnd;
  dbgDocumentos.DataSource := dtsComEnd;

  strNomeTabela := 'COMENG';
  strNomeCampo  := 'ENG_PROENT';
  qryTabela     := objComEnt.qryComEng;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeProEnt;

  pAjustaTela;
end;

function TfrmCadComEntregadores.fPodeInserir: Boolean;
begin
  If (objComEnt.GetInsDoc = idoBarras) Then
  Begin
    Result := fValidaCampos(edtCodBar, True);
  End
  Else
  Begin
    Result := fValidaCampos(edtDocume, True)     And
              fValidaCampos(edtEspDoc, True)     And
              fValidaCampos(edtCodEmpresa, True) And
              fValidaCampos(edtCodCidade, True);
  End;
end;

function TfrmCadComEntregadores.fRetCodigoEmpresa: String;
begin
  If (objComEnt.GetInsDoc = idoBarras) Then
    Result := fRetEmpresaDocumentoCodigoBarras
  Else
    Result := edtCodEmpresa.Text;
end;

function TfrmCadComEntregadores.fRetNumeroDocumentoCodigoBarras: String;
begin
  Result := '';

  If (Length(edtCodBar.Text) = 18) Or (Length(edtCodBar.Text) = 44) Then
  Begin
    If (Length(edtCodBar.Text) = 18) Then
      Result := Copy(edtCodBar.Text, INT_POS_NUMDOC_BARRAS_EAN39, 12)
  End;
end;

function TfrmCadComEntregadores.fRetornaTipoDeRelatorio(
  const frmDigCadComEntregadores: TfrmDigCadComEntregadores): Integer;
begin
  Result := 0;

  If Not frmDigCadComEntregadores.rdgTipImp.Visible Then
    Exit;

  Result := frmDigCadComEntregadores.rdgTipImp.ItemIndex;
end;

function TfrmCadComEntregadores.fRetEmpresaDocumentoCodigoBarras: String;
begin
  Result := '';

  If (Length(edtCodBar.Text) = 18) Or (Length(edtCodBar.Text) = 44) Then
  Begin
    If (Length(edtCodBar.Text) = 18) Then
      Result := Copy(edtCodBar.Text, INT_POS_CODEMP_BARRAS_EAN39, 3);
  End;
end;

function TfrmCadComEntregadores.fRetEspecieDocumento: String;
begin
  If (objComEnt.GetInsDoc = idoBarras) Then
    Result := fRetEspecieDocumentoCodigoBarras
  Else
    Result := edtEspDoc.Text;
end;

function TfrmCadComEntregadores.fRetEspecieDocumentoCodigoBarras: String;
Var
  intCodEsp: Integer;
begin
  Result := '';

  If (Length(edtCodBar.Text) = 18) Or (Length(edtCodBar.Text) = 44) Then
  Begin
    If (Length(edtCodBar.Text) = 18) Then
    Begin
      intCodEsp := strToIntDef(Copy(edtCodBar.Text, INT_POS_ESPDOC_BARRAS_EAN39, 2), 0);

      If (intCodEsp > 0) Then
      Begin
        If (intCodEsp <= Length(ARR_ESPDOC_TO_CODE)) Then
          Result := ARR_ESPDOC_TO_CODE[intCodEsp]
        Else
          fMensagem('', 'Não foi possível identificar a Espécie do Documento!', ['&O k']);
      End;
    End;
  End;
end;

function TfrmCadComEntregadores.fRetNumeroDocumento: String;
begin
  If (objComEnt.GetInsDoc = idoBarras) Then
    Result := fRetNumeroDocumentoCodigoBarras
  Else
    Result := edtDocume.Text;
end;

function TfrmCadComEntregadores.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;
  objComEnt.strEspPer := AnsiReplaceStr(edtEspDoc.Hint, ' ','');

  Try
    If (Sender = dbeProEnt) And dbeProEnt.Enabled Then
      objComEnt.strProEnt := dbeProEnt.Text

    Else If (Sender = edtSenMot) Then
    Begin

      If objComEnt.GetTipEnt = tenCodigo Then
      Begin
        If fEmptyStr(edtSenMot.Text) Then
          objComEnt.strCodEnt := ''
        Else
        Begin
          fDadosMotorista(edtSenMot.Text);
          edtNomMot.Text := fRetNomeMotorista(edtSenMot.Text, True);
        End;

        If fEmptyStr(edtNomMot.Text) And (Not fEmptyStr(edtSenMot.Text))  Then
        Begin
          fMensagem('','Código do entregador não encontrado.', ['&OK']);
          Result := False;
        End;

      End
      Else
      Begin
        If (objComEnt.GetTipEnt = tenBarras) And (Length(edtSenMot.Text) <> 13) Then
        Begin
          fMensagem('', 'O Código de Barras do Entregador é inválido!', ['&OK']);
          Result := False;
        End
        Else If fEmptyStr(edtSenMot.Text)  Then
        Begin
          If (objComEnt.GetTipEnt = tenSenha) Then
            fMensagem('', 'A Senha do Entregador deve ser preenchida.', ['&OK'])
          Else
            fMensagem('', 'O Código de Barras do Entregador deve ser preenchido.', ['&OK']);

          Result := False;
        End
        Else
        Begin
          if fDadosMotorista(edtSenMot.Text) then
          begin
            edtNomMot.Text := fRetNomeMotorista(objComEnt.strCodEnt, True);

            If fEmptyStr(edtNomMot.Text) And (Not fEmptyStr(edtSenMot.Text))  Then
            Begin
              fMensagem('','Entregador não encontrado.', ['&OK']);
              Result := False;
            End;
          end
          else
          begin
            fMensagem('','Entregador não encontrado.', ['&OK']);
            Result := False;
          end;
        End;
      End;

      If (Result) And (blnBuscaPorChave) Then
      Begin
        If (fEmptyStr(objComEnt.strPlaVei)) Then
        Begin
          dbePlaVei.Field.Value := Null;
          edtDesVei.Clear;
        End
        Else
        Begin
          If (dbePlaVei.Field.Value = Null)     Or
             (fEmptyStr(dbePlaVei.Field.Value)) Then
          Begin
            dbePlaVei.Field.Value := objComEnt.strPlaVei;
            edtDesVei.Text := fRetornaDescricaoVeic(dbePlaVei.Text);
          End
          Else
            objComEnt.strPlaVei := dbePlaVei.Field.Value;

        End;
      End;

    End

    Else If (Sender = dbePlaVei) Then
    Begin

      If fVeiculoInativo(dbePlaVei.Text) Then
      Begin
        edtDesVei.Text := '';
        fMensagem('','Este veículo está inativo.',['&O k']);
        Result := False;
      End
      Else
      Begin
        If Not fEmptyStr(fTiraCaracEspeciais(dbePlaVei.Text)) Then
        Begin
          edtDesVei.Text := fRetornaDescricaoVeic(dbePlaVei.Text);
          If fEmptyStr(edtDesVei.Text) Then
          Begin
            Result := False;
            fMensagem('','Nenhum veículo cadastrado com esta placa!',['&Ok']);
            Exit;
          End;
        End
        Else
          edtDesVei.Clear;

        objComEnt.strPlaVei := dbePlaVei.Text;
      End;
    End

    Else If (Sender = edtDocume) And blnBuscaPorChave Then
      objComEnt.strDocume := fRetNumeroDocumento

    Else If (Sender = edtEspDoc) And blnBuscaPorChave Then
      objComEnt.strEspDoc := fRetEspecieDocumento

    Else If (Sender = edtCodEmpresa) And blnBuscaPorChave Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);
        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          Result := False;
          fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
          Exit;
        End;
      End;

      objComEnt.strEmpDoc := fRetCodigoEmpresa;
    End

    Else If (Sender = edtCodCidade) And blnBuscaPorChave Then
    Begin
      If Not fEmptyStr(edtCodCidade.Text) Then
      Begin
        edtDesCidade.Text := fRetNomCidade(edtCodCidade.Text);
        If fEmptyStr(edtDesCidade.Text) Then
        Begin
          Result := False;
          fMensagem('AVISO','Código da cidade não encontrado.', ['&O K']);
          Exit;
        End;
      End;

      objComEnt.strCodCid := edtCodCidade.Text;
    End

    Else If (Sender = edtCodBar) And blnBuscaPorChave Then
    Begin
      If (Length(edtCodBar.Text) = 18) Or (Length(edtCodBar.Text) = 44) Then
      Begin
        If fSetaDadosDocumentoCodigoBarras Then
        Begin
          pControlaCampoCidade(objComEnt.strEspDoc);

          If (Not edtCodCidade.Enabled) Then
          Begin
            If (Not fEmptyStr(edtCodBar.Text))Then
              btnAdicionar.Click;

            blnMudarFoco := False;
          End;
        End
        Else
        Begin
          pLimpaDadosDocumento;
          blnMudarFoco := False;
        End;
      End
      Else
      Begin
        fMensagem('','O Código de Barras informado é inválido!',['&Ok']);
        pLimpaDadosDocumento;
        Result := False;
      End;
    End;

  Except
    On E: ExceptionAutCom Do
    Begin
			   fMensagem('',E.Message,['&OK']);
      Result := False;
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[ValidaCampos ->' + Sender.Name + ']');
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadComEntregadores.pInicializaIndices;
begin
  inherited;

  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('ENG_PROENT');
  stlCamInd.Add('ENG_CODENT');
  stlCamInd.Add('MOT_NOMMOT');
  stlCamInd.Add('ENG_DTACAD');
  stlCamInd.Add('ENG_PLAVEI');

  stlDesInd.Add('Num.Entrega');
  stlDesInd.Add('Código Entregador');
  stlDesInd.Add('Nome Entregador');
  stlDesInd.Add('Data de Cadastro');
  stlDesInd.Add('Veículo');
end;

procedure TfrmCadComEntregadores.btnPesquisaClick(Sender: TObject);
  Var
    arrSel : TConsultasArray;
    chrKey : Char;

begin

  chrKey := '/';

  If fPesqContEnt(Self, dbeProEnt, qryTabela, chrKey, arrSel) Then
  Begin
    If (objComEnt.GetTipEnt in ([tenCodigo, tenSenha])) Then
    Begin
      edtSenMot.Text := qryTabela.FieldByName('ENG_CODENT').AsString;
    End;

    edtNomMot.Text := fRetNomeMotorista(qryTabela.FieldByName('ENG_CODENT').AsString, True);
    edtDesVei.Text := fRetornaDescricaoVeic(qryTabela.FieldByName('ENG_PLAVEI').AsString);
    pSetFocus(btnAlterar);
  End;

  pBaixada;
end;

procedure TfrmCadComEntregadores.Button1Click(Sender: TObject);
begin
  inherited;
  TfrxBarCodeView(frxReport1.FindObject('BarCode1')).Text := edtSenMot.Text;
  pPreviewReport(Self.Name, Self.Caption, frxReport1);
end;

{*****************************************}
{* LIMPA DADOS                           *}
{**************************************AF*}
procedure TfrmCadComEntregadores.pLimpaDados(blnSetFocus: Boolean = TRUE);
begin
  pLimpaDadosDocumento;

  edtNomMot.Clear;
  edtDesVei.Clear;
  edtSenMot.Clear;

  edtCodCidade.Clear;
  edtDesCidade.Clear;

  edtNumAju.Clear;

  If blnSetFocus Then
    pFocaCampoDocumento;
end;

procedure TfrmCadComEntregadores.pLimpaDadosDocumento;
begin
  edtDocume.Clear;
  edtCodBar.Clear;
  edtEspDoc.Clear;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa(VS_strCodEmp);
end;

function TfrmCadComEntregadores.fSetaDadosDocumentoCodigoBarras: Boolean;
Var
  strEspDoc: String;
begin
  Result := False;

  Try
    If (Length(edtCodBar.Text) = 18) Then
    Begin
      strEspDoc := fRetEspecieDocumento;

      If (Not fEmptyStr(strEspDoc)) Then
      Begin
        objComEnt.strEspDoc := strEspDoc;
        objComEnt.strDocume := fRetNumeroDocumento;
        objComEnt.strEmpDoc := fRetCodigoEmpresa;
        Result := True;
      End
      Else
        Result := False;
    End
    Else
    Begin
      objComEnt.setChaAce(edtCodBar.Text);
      Result := objComEnt.fSetaDadosDocumentoChaveAcesso;

      If (Not Result) Then
        fMensagem('', 'O Chave de Acesso ' + objComEnt.getChaAce + ' não foi encontrada no Livro Fiscal.' + #13#10+
                      'Verifique com o Responsável pela Área Fiscal.', ['O k']);

    End;
  Except
    On E: ExceptionAutCom Do
    Begin
      fMensagem('',E.Message,['&OK']);
      pLimpaDadosDocumento;
    End;
  End;
end;

procedure TfrmCadComEntregadores.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimpaDadosDocumento;
  pFocaCampoDocumento;
end;

procedure TfrmCadComEntregadores.dbgDocumentosDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
  Var
    strChaveDoc: String;
    
  function fCampo(strCampo: String): TField;
  begin
    Result := objComEnt.cdsComEnd.FieldByName('END_' + strCampo);
  end;

begin
  inherited;

  If Not Assigned(objComEnt) Then Exit;
  If Not objComEnt.cdsComEnd.Active Then Exit;

  If objComEnt.cdsComEnd.RecordCount > 0 Then
  Begin
    strChaveDoc := Concat(fCampo('NUMDOC').AsString, fCampo('ESPDOC').AsString, fCampo('EMPDOC').AsString, fCampo('CODCLI').AsString);

    If dicEntUrg[strChaveDoc] = Null Then
    Begin
      dicEntUrg[strChaveDoc] :=
        fDocumentoComEntregaUrgente(fCampo('NUMDOC').AsString, fCampo('ESPDOC').AsString, fCampo('EMPDOC').AsString, fCampo('CODCLI').AsString);
    End;

    If dicEntUrg[strChaveDoc] Then
    Begin
      dbgDocumentos.Canvas.Font.Color := clRed;
      dbgDocumentos.Canvas.Font.Style := [fsBold];
      dbgDocumentos.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    End;

    If (Column.Field.DataSet.RecNo Mod 2) = 0 Then
    Begin
      dbgDocumentos.Canvas.Brush.Color := fCfgSis('CORZEB');
      dbgDocumentos.Canvas.FillRect(Rect);
      dbgDocumentos.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    End;
  End;

end;

procedure TfrmCadComEntregadores.bntEntregasClick(Sender: TObject);
var
  frmFatMotEntregas: TfrmFatMotEntregas;
begin
  inherited;

  pCriarFormularios(TfrmFatMotEntregas, frmFatMotEntregas);

  try
    frmFatMotEntregas.FEspeciesPermitidas := edtEspDoc.Hint;
    frmFatMotEntregas.ShowModal;
  finally
    pFreeAndNil(frmFatMotEntregas);
  end;
end;


procedure TfrmCadComEntregadores.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  If Not ((qryTabela.State = dsEdit) Or (qryTabela.State = dsInsert)) Then
    Exit;

  If (fPodeInserir) Then
  Begin
    If (objComEnt.fInsereRegistro) Then
      pLimpaDadosDocumento
    Else If (objComEnt.GetInsDoc = idoBarras) Then
      pLimpaDadosDocumento;
  End;

  pFocaCampoDocumento;
end;

procedure TfrmCadComEntregadores.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  if dtsComEnd.DataSet.RecordCount <= 0 Then
  Begin
    fMensagem('ATENÇÃO', 'Digite os Documentos antes de gravar o Controle de Entrega!', ['&OK']);
    Exit;
  End;

  If qryTabela.State = dsInsert Then
  Begin
    qryTabela.FieldByName('ENG_CODENT').AsString   := objComEnt.strCodEnt;
    qryTabela.FieldByName('ENG_DTACAD').AsDateTime := VS_Date;
    qryTabela.FieldByName('ENG_HRACAD').AsDateTime := fTime();
  End;

  {**************************************}
  {* POIS O EDTSENMOT E APENAS EDITFOCUS*}
  {************************************LE}
  If (qryTabela.State = dsEdit) And (Not fEmptyStr(edtSenMot.Text)) Then
  Begin
    If (objComEnt.GetTipEnt in [tenSenha, tenBarras]) Then
    Begin
      fDadosMotorista(edtSenMot.Text); //Convertendo senha para o Código
      qryTabela.FieldByName('ENG_CODENT').AsString :=  objComEnt.strCodEnt;
    End
    Else
      qryTabela.FieldByName('ENG_CODENT').AsString :=  objComEnt.strCodEnt;
  End;

  If (fEmptyStr(fTiraCaracEspeciaisParenteses(dbePlaVei.Text))) Then
    qryTabela.FieldByName('ENG_PLAVEI').Value := Null;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadComEntregadores.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  Begin
    Try
      objComEnt.pSalvaComEnd;
      objComEnt.pAlteraSituacaoMotorista('E');

      if (not fValidaGravacaoCOMEND(qryTabela.FieldByName('AUTOINCREM').AsString)) then
      begin
        fRollback;
        fMensagem('ATENÇÃO', 'Houve uma inconsistência na gravação dos dados (COMENG sem COMEND). por favor, entre em contato com a Citel!', ['&OK']);
        Exit;
      end;

      fCommit;

      Try

        pCriarFormularios(TfrmDigCadComEntregadores, frmDigCadComEntregadores);
        frmDigCadComEntregadores.ShowModal;

        If (frmDigCadComEntregadores.ModalResult = mrOk) And (frmDigCadComEntregadores.edtImpCom.Text = 'S') Then
          objComEnt.pImprimeRegistro(frmDigCadComEntregadores.strImpEnd,  frmDigCadComEntregadores.strImpAss,
            fRetornaTipoDeRelatorio(frmDigCadComEntregadores));

        pBaixada;

        If (objComEnt.GetTipEnt <> tenCodigo) And
           (objComEnt.GetTipEnt <> tenSenha) Then
        Begin
          edtSenMot.Clear;
        End;

      Finally
        pFreeAndNil(frmDigCadComEntregadores);
      End;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message,'[btnGravarClick]');
      End;
    End;
  End
  Else
    fRollBack;
end;

procedure TfrmCadComEntregadores.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeProEnt, TDBEdit(edtSenMot), False)
  Else
    pHabilitaCodigo(dbeProEnt, dbeProEnt, True);

  pBaixada;

  pLimpaDados(False);  
end;

procedure TfrmCadComEntregadores.btnAlterarClick(Sender: TObject);
begin
  If qryTabela.RecordCount <= 0 Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;
  inherited;
  pHabilitaCodigo(dbeProEnt, TDBEdit(edtSenMot), False);

  If (objComEnt.GetTipEnt = tenCodigo) Then
    objComEnt.strCodEnt := edtSenMot.Text;
end;

procedure TfrmCadComEntregadores.dbePlaVeiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrVeic: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE VEÍCULOS   *}
  {****************************RV*}
  If fPesqVeiculos(Self, dbePlaVei, edtDesVei, Nil, Key, arrVeic, True, True, ' VEI_STATUS = "A" ') Then
  Begin
    If fValidaCampos(dbePlaVei, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadComEntregadores.btnCancelaClick(Sender: TObject);
begin
  inherited;
  qryTabela.Close;
  qryTabela.Open;
  pBaixada;
  pLimpaDados;

  {***************************}
  {Carregando dados anteriores}
  {*************************LE}
  If Not fEmptyStr(dbePlaVei.Text) Then
  Begin
    edtDesVei.Text := fRetornaDescricaoVeic(dbePlaVei.Text);
    edtNomMot.Text := fRetNomeMotorista(qryTabela.FieldByName('ENG_CODENT').AsString, True);

    If (objComEnt.GetTipEnt = tenCodigo) Then
      edtSenMot.Text := qryTabela.FieldByName('ENG_CODENT').AsString;

  End;

end;

procedure TfrmCadComEntregadores.btnExcluirClick(Sender: TObject);
begin
  If qryTabela.RecordCount <= 0 Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  objComEnt.strCodEnt := edtSenMot.Text;
  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadComEntregadores.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    objComEnt.pAlteraSituacaoMotorista('D');
    pLimpaDados;
    fCommit
  End
  Else
    fRollBack;

  qryTabela.Close;
  qryTabela.Open;
  pBaixada;

end;

procedure TfrmCadComEntregadores.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Delete: Begin
                 If qryTabela.State In [dsEdit, dsInsert] Then
                 Begin
                   If (Not objComEnt.cdsComEnd.IsEmpty) Then
                   Begin
                     If fMensagem('','Deseja excluir o registro?',['','']) = 1 Then
                       objComEnt.cdsComEnd.Delete;
                   End;
                   pFocaCampoDocumento;
                 End;
               End;
  End;
end;

procedure TfrmCadComEntregadores.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: If btnGravar.Enabled Then btnGravar.Click;
  End;
  
end;

procedure TfrmCadComEntregadores.edtEspDocEnter(Sender: TObject);
begin
  inherited;
  HintControler.ShowHint(Self.Left + edtEspDoc.Left + edtEspDoc.Width,
                         15 + Self.Top + edtEspDoc.Top + edtEspDoc.Height, 'Espécies permitidas:', edtEspDoc.Hint);
end;

procedure TfrmCadComEntregadores.edtEspDocExit(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
  pControlaCampoCidade(edtEspDoc.Text);
end;

procedure TfrmCadComEntregadores.edtEspDocKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Key = '-' Then
    Key := #0;

end;

procedure TfrmCadComEntregadores.edtSenMotKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrMot: TConsultasArray;
begin
  If objComEnt.GetTipEnt in [tenSenha, tenBarras] Then
    Exit;
  {*******************************}
  {* NOVA CONSULTA DE MOTORISTAS *}
  {****************************RV*}
  If fPesqMotorista(Self, edtSenMot, Nil, Nil, Key, arrMot, True, True) Then
  Begin
    If fValidaCampos(edtSenMot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadComEntregadores.pAjustaCampoDocumento;
begin
  pnlCodBar.Visible := (objComEnt.GetInsDoc = idoBarras);
  pnlDocume.Visible := (Not pnlCodBar.Visible);
end;

procedure TfrmCadComEntregadores.pAjustaCampoEntregador;
begin
  If (objComEnt.GetTipEnt In [tenSenha, tenBarras]) Then
  Begin
    edtSenMot.Width     := 121;
    edtNomMot.Width     := 380;
    edtNomMot.Left      := 219;
    edtSenMot.MaxLength := 13;

    If (objComEnt.GetTipEnt = tenSenha) Then
      edtSenMot.MaxLength := 10;
  End
  Else
  Begin
    edtSenMot.Width := 63;
    edtNomMot.Width := 438;
    edtNomMot.Left  := 161;

    edtSenMot.PasswordChar := #0;
    edtSenMot.MaxLength    := 5;
    edtSenMot.TamCampo     := 5;
    edtSenMot.CompZeros    := True;
  End;
end;

procedure TfrmCadComEntregadores.pAjustaTela;
begin
  pAjustaCampoEntregador;
  pAjustaCampoDocumento;
end;

procedure TfrmCadComEntregadores.pBaixada;
begin
  If qryTabela.Active And objComEnt.fEntregaBaixada(qryTabela.FieldByName('ENG_PROENT').AsString) Then
  Begin
    lblBaixada.Visible := True;
    btnAlterar.Enabled := False;
  End
  Else
  Begin
    lblBaixada.Visible := False;
    If Not (qryTabela.State = dsInsert) Then
      btnAlterar.Enabled := True;
  End;
end;

procedure TfrmCadComEntregadores.pControlaCampoCidade(strEspDoc: String);
begin
  edtCodCidade.Enabled := SameText(strEspDoc,'OS');

  If Not edtCodCidade.Enabled Then
  Begin
    edtCodCidade.Clear;
    edtDesCidade.Clear;
  End;
end;

procedure TfrmCadComEntregadores.edtCodCidadeKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCidade, edtDesCidade, Nil, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(edtCodCidade, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.

