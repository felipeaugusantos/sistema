unit untCadBeneficioFiscal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, StrUtils,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, ComboBoxFocus, EditFocus, Data.DB, MemDS, DBAccess, Uni;

type
  TfrmCadBeneficioFiscal = class(TfrmPaiCad)
    pnlFundo: TPanel;
    lblCodigo: TLabel;
    dbeCodigo: TDBEditFocus;
    lblDescricao: TLabel;
    dbeDescricao: TDBEditFocus;
    lblCST: TLabel;
    lblCFOP: TLabel;
    lblPerfilAbreviacao: TLabel;
    dbeCodCFOP: TDBEditFocus;
    dbeCodCST: TDBEditFocus;
    edtDescCFOP: TEditFocus;
    edtDescCST: TEditFocus;
    cmbTipAbf: TComboBoxFocus;
    dtsCadBef: TDataSource;
    dbeTipAbf: TDBEditFocus;
    dbeEmpresa: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbeCodCSTKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodCFOPKeyPress(Sender: TObject; var Key: Char);
    procedure cmbTipAbfChange(Sender: TObject);
    procedure cmbTipAbfCloseUp(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    qryEmpresas: TUniQuery;
    FCfoOri: String;
    FCstOri: String;
    FPerOri: String;
    FCodEmp: String;
    function  fBuscaCST(strCodCST: string): string;
    function  fBuscaCFOP(strCodCFOP: string): string;
    procedure pSetaPerfilAbreviacao;
    procedure pSetaComboPerfilAbreviacao;
    procedure pCarregaEmpresas;
    procedure pRegistraChave;
    function fRegistroExiste: Boolean;
    function fGravaRegistros: Boolean;
    function fDeletaRegistros: Boolean;
    function fDeletaRegistro(ACfopBf, ACstBef, APerAbr, ACodEmp: String): Boolean;
    function fCadastraRegistros: Boolean;
    function fCadastraRegistro(ACfopBf, ACstBef, APerAbr, ADescri, ACodBen, ACodEmp: String): Boolean;
  protected
    procedure pInicializaIndices; override;
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadBeneficioFiscal.btnAlterarClick(Sender: TObject);
begin
  cmbTipAbf.Enabled := True;
  inherited;
  pRegistraChave;
end;

procedure TfrmCadBeneficioFiscal.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pRegistraChave;
  edtDescCFOP.Clear;
  edtDescCST.Clear;
  cmbTipAbf.Enabled := False;
  if Trim(dbeCodigo.Text) = '' then
  begin
    cmbTipAbf.ItemIndex := -1;
  end
  else if qryTabela.FieldByName('BEF_PERABR').AsString <> '' then
    pSetaComboPerfilAbreviacao;
end;

procedure TfrmCadBeneficioFiscal.btnExcluirClick(Sender: TObject);
begin
  pCarregaEmpresas;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadBeneficioFiscal.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    blnExcluiu := fDeletaRegistros;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  cmbTipAbf.ItemIndex := -1;
  cmbTipAbf.Enabled := False;
  edtDescCFOP.Clear;
  edtDescCST.Clear;
end;

procedure TfrmCadBeneficioFiscal.btnGravarClick(Sender: TObject);
begin
  blnUsaProCodigo := False;
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  if cmbTipAbf.ItemIndex > -1 then
  begin
    if cmbTipAbf.ItemIndex < 6 then
    begin
      qryTabela.FieldByName('BEF_PERABR').AsString := '_ENT_' + Copy(cmbTipAbf.Text,1,3);
    end
    else
    begin
      qryTabela.FieldByName('BEF_PERABR').AsString := '_SAI_' + Copy(cmbTipAbf.Text,1,3);
    end;

  end
  else
  begin
    qryTabela.FieldByName('BEF_PERABR').Clear;
  end;

  If fRegistroExiste Then
  Begin
    fMensagem('','Já existe um registro com essa combinação. Verifique!', ['&Ok']);
    Exit;
  End;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadBeneficioFiscal.btnGravarClick]');
    End;
  End;

  If blnGravou then
    blnGravou := fGravaRegistros;

  if blnGravou then
  begin
    cmbTipAbf.Enabled := False;
    fCommit;
    pRegistraChave;
  end
  Else
    fRollBack;
end;

procedure TfrmCadBeneficioFiscal.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pRegistraChave;
  cmbTipAbf.ItemIndex := -1;
  cmbTipAbf.Enabled := True;
  edtDescCFOP.Clear;
  edtDescCST.Clear;
  pSetFocus(dbeCodigo);
end;

procedure TfrmCadBeneficioFiscal.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrAtiv: TConsultasArray;
begin
  chrKey := '/';
  If fPesqBeneficioFiscal(Self, Nil, Nil, qryTabela, chrKey, arrAtiv) Then
  begin
    pRegistraChave;
    pSetaComboPerfilAbreviacao;
    edtDescCFOP.Text := fBuscaCFOP(dbeCodCFOP.Text);
    edtDescCST.Text := fBuscaCST(dbeCodCST.Text);
    pSetFocus(btnAlterar);
  end;
end;

procedure TfrmCadBeneficioFiscal.cmbTipAbfChange(Sender: TObject);
begin
  pSetaPerfilAbreviacao;
end;

procedure TfrmCadBeneficioFiscal.cmbTipAbfCloseUp(Sender: TObject);
begin
  pSetaPerfilAbreviacao;
end;

procedure TfrmCadBeneficioFiscal.dbeCodCFOPKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSitTrib: TConsultasArray;
begin
  inherited;
  If fPesqCFOP(Self, TEditFocus(Sender), Nil, Nil, Key, arrSitTrib) Then
  begin
    fValidaCampos(TEditFocus(Sender));
  end;
end;

procedure TfrmCadBeneficioFiscal.dbeCodCSTKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSitTrib: TConsultasArray;
begin
  inherited;
  If fPesqSitTributaria(Self, TEditFocus(Sender), Nil, Nil, Key, arrSitTrib) Then
  begin
    fValidaCampos(TEditFocus(Sender));
  end;
end;

function TfrmCadBeneficioFiscal.fBuscaCFOP(strCodCFOP: string): string;
var
  strSQL: string;
  qryCFOP: TUniQuery;
begin
  try
    Result := '';

    qryCFOP := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CFO_DESCR1 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCFO ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CFO_CODCFO = :CODCFO';

    qryCFOP.Close;
    qryCFOP.SQL.Clear;
    qryCFOP.SQL.Add(strSQL);
    qryCFOP.ParamByName('CODCFO').AsString := strCodCFOP;
    qryCFOP.Open;

    if not qryCFOP.IsEmpty then
    begin
      Result := qryCFOP.FieldByName('CFO_DESCR1').AsString;
    end;
  finally
    FreeAndNil(qryCFOP);
  end;
end;

function TfrmCadBeneficioFiscal.fBuscaCST(strCodCST: string): string;
var
  strSQL: string;
  qryCST: TUniQuery;
begin
  try
    Result := '';

    qryCST := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  TRI_DESC01 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADTRI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TRI_CODTRI = :CODTRI';

    qryCST.Close;
    qryCST.SQL.Clear;
    qryCST.SQL.Add(strSQL);
    qryCST.ParamByName('CODTRI').AsString := strCodCST;
    qryCST.Open;

    if not qryCST.IsEmpty then
    begin
      Result := qryCST.FieldByName('TRI_DESC01').AsString;
    end;
  finally
    FreeAndNil(qryCST);
  end;
end;

procedure TfrmCadBeneficioFiscal.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CADBEF';
  strNomeCampo  := 'AUTOINCREM';
  qryTabela := fCriarQuery('SELECT * FROM CADBEF', Self);
  dtsCadBef.DataSet := qryTabela;

  SetLength(arrCamposChave, 5);
  arrCamposChave[0] := dbeCodigo;
  arrCamposChave[1] := dbeCodCFOP;
  arrCamposChave[2] := dbeCodCST;
  arrCamposChave[3] := dbeTipAbf;
  arrCamposChave[4] := dbeEmpresa;

  qryEmpresas := fCriaQuery();
end;

procedure TfrmCadBeneficioFiscal.FormShow(Sender: TObject);
begin
  inherited;
  cmbTipAbf.ItemIndex := -1;
  pSetFocus(btnIncluir);
end;

function TfrmCadBeneficioFiscal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  begin
    if (Sender = dbeCodigo) then
    begin
      if fEmptyStr(dbeCodigo.Text) or (Length(Trim(dbeCodigo.Text)) < 8) then
      begin
        fMensagem('','Preencher corretamente o código!', ['&Ok']);
        Result := False;
      end
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    end
    else
    if (Sender = dbeDescricao) then
    begin
      if fEmptyStr(dbeDescricao.Text) then
      begin
        fMensagem('','Preencher corretamente a descrição!', ['&Ok']);
        Result := False;
      end;
    end
    else
    if (Sender = dbeCodCFOP) then
    begin
      if (fEmptyStr(dbeCodCFOP.Text)) or (Length(Trim(dbeCodCFOP.Text))<>4) then
      begin
        fMensagem('','Preencher corretamente o CFOP!', ['&Ok']);
        Result := False;
        Exit;
      end
      else
      begin
        edtDescCFOP.Text := fBuscaCFOP(dbeCodCFOP.Text);
      end;
      if Trim(edtDescCFOP.Text) = '' then
      begin
        fMensagem('','Preencher corretamente o CFOP!', ['&Ok']);
        Result := False;
      end;
    end
    else
    if (Sender = dbeCodCST) then
    begin
      if (fEmptyStr(dbeCodCST.Text)) or (Length(Trim(dbeCodCST.Text))<>3) then
      begin
        fMensagem('','Preencher corretamente o CST!', ['&Ok']);
        Result := False;
        Exit;
      end
      else
      begin
        edtDescCST.Text := fBuscaCST(dbeCodCST.Text);
      end;
      if Trim(edtDescCST.Text) = '' then
      begin
        fMensagem('','Preencher corretamente o CST!', ['&Ok']);
        Result := False;
      end;
    end
    else
    if (Sender = cmbTipAbf) then
    begin
      if (cmbTipAbf.ItemIndex = -1) then
      begin
        fMensagem('','Preencher corretamente o perfil a abreviação!', ['&Ok']);
        Result := False;
      end;
    end;
  end;
  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadBeneficioFiscal.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BEF_CODEMP');
  stlCampos.Add('BEF_CODIGO');
  stlCampos.Add('BEF_DESBEF');
  stlCampos.Add('BEF_CFOPBF');
  stlCampos.Add('BEF_CSTBEF');
  stlCampos.Add('BEF_PERABR');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BEF_CODEMP');
  stlCamInd.Add('BEF_CODIGO');
  stlCamInd.Add('BEF_DESBEF');
  stlCamInd.Add('BEF_CFOPBF');
  stlCamInd.Add('BEF_CSTBEF');
  stlCamInd.Add('BEF_PERABR');

  stlDesInd.Add('Cód. Empresa');
  stlDesInd.Add('Código');
  stlDesInd.Add('descrição');
  stlDesInd.Add('CFOP');
  stlDesInd.Add('CST');
  stlDesInd.Add('Perfil abreviação');
end;

procedure TfrmCadBeneficioFiscal.pSetaComboPerfilAbreviacao;
begin
  cmbTipAbf.ItemIndex := AnsiIndexStr(qryTabela.FieldByName('BEF_PERABR').AsString, ['_ENT_PEF', '_ENT_PEJ', '_ENT_PER', '_ENT_PES', '_ENT_PSI', '_ENT_PII', '_SAI_NCO', '_SAI_CCO', '_SAI_CNC', '_SAI_SNA', '_SAI_CTA', '_SAI_PRU', '_SAI_IND', '_SAI_TRS']);
end;

procedure TfrmCadBeneficioFiscal.pSetaPerfilAbreviacao;
begin
  if (qryTabela.State in [dsInsert, dsEdit]) and (cmbTipAbf.ItemIndex > -1) then
  begin
    if cmbTipAbf.ItemIndex < 6 then
      qryTabela.FieldByName('BEF_PERABR').AsString := '_ENT_' + Copy(cmbTipAbf.Text,1,3)
    else
      qryTabela.FieldByName('BEF_PERABR').AsString := '_SAI_' + Copy(cmbTipAbf.Text,1,3);
  end;
end;

procedure TfrmCadBeneficioFiscal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If Assigned(qryEmpresas) Then
    FreeAndNil(qryEmpresas);
end;

procedure TfrmCadBeneficioFiscal.pCarregaEmpresas;
begin
  qryEmpresas.Close;
  qryEmpresas.SQL.Clear;
  qryEmpresas.SQL.Add('SELECT ');
  qryEmpresas.SQL.Add('  EMP_DES.EMP_CODEMP ');
  qryEmpresas.SQL.Add('FROM CADEMP EMP_ORI ');
  qryEmpresas.SQL.Add('INNER JOIN CADCID CID_ORI ON EMP_ORI.EMP_CODCID = CID_ORI.CID_CODCID ');
  qryEmpresas.SQL.Add('INNER JOIN CADEMP EMP_DES ON LEFT(EMP_ORI.EMP_C_G_C_, 8) = LEFT(EMP_DES.EMP_C_G_C_, 8) ');
  qryEmpresas.SQL.Add('INNER JOIN CADCID CID_DES ON EMP_DES.EMP_CODCID = CID_DES.CID_CODCID ');
  qryEmpresas.SQL.Add('                         AND CID_DES.CID_ESTADO = CID_ORI.CID_ESTADO ');
  qryEmpresas.SQL.Add('WHERE EMP_ORI.EMP_CODEMP  = :CODEMP ');
  qryEmpresas.SQL.Add('  AND EMP_DES.EMP_CODEMP <> :CODEMP ');
  qryEmpresas.ParamByName('CODEMP').AsString := IfEmptyStr(FCodEmp, VS_strCodEmp);
  qryEmpresas.Open;
end;

procedure TfrmCadBeneficioFiscal.pRegistraChave;
begin
  FCfoOri := qryTabela.FieldByName('BEF_CFOPBF').AsString;
  FCstOri := qryTabela.FieldByName('BEF_CSTBEF').AsString;
  FPerOri := qryTabela.FieldByName('BEF_PERABR').AsString;
  FCodEmp := qryTabela.FieldByName('BEF_CODEMP').AsString;
end;

function TfrmCadBeneficioFiscal.fRegistroExiste: Boolean;
begin
  Result := False;

  If not (qryTabela.state = dsInsert) Then
    Exit;

  Result := not fEmptyStr(fCampoTabela('AUTOINCREM', 'CADBEF', ['BEF_CFOPBF', 'BEF_CSTBEF', 'BEF_PERABR', 'BEF_CODEMP'],
                                                               [qryTabela.FieldByName('BEF_CFOPBF').AsString,
                                                                qryTabela.FieldByName('BEF_CSTBEF').AsString,
                                                                qryTabela.FieldByName('BEF_PERABR').AsString,
                                                                IfEmptyStr(FCodEmp, VS_strCodEmp)
                                                                ]));
end;

function TfrmCadBeneficioFiscal.fGravaRegistros: Boolean;
begin
  Result := True;

  pCarregaEmpresas;

  If not fDeletaRegistros Then
  Begin
    fMensagem('','Não foi possível deletar os registros com essa combinação!', ['&Ok']);
    Result := False;
    Exit;
  End;

  If not fCadastraRegistros Then
  Begin
    fMensagem('','Não foi possível cadastrar os registros com essa combinação!', ['&Ok']);
    Result := False;
    Exit;
  End;
end;

function TfrmCadBeneficioFiscal.fDeletaRegistros: Boolean;
begin
  Result := True;

  qryEmpresas.First;
  While not qryEmpresas.eof Do
  Begin
    If not fDeletaRegistro(FCfoOri, FCstOri, FPerOri, qryEmpresas.FieldByName('EMP_CODEMP').AsString) Then
    Begin
      Result := False;
      Break;
    End;

    qryEmpresas.Next;
  End;
end;

function TfrmCadBeneficioFiscal.fDeletaRegistro(ACfopBf, ACstBef, APerAbr, ACodEmp: String): Boolean;
var
  qryAux: TUniQuery;
begin
  Result := True;

  qryAux := fCriaQuery();

  Try
    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('DELETE FROM CADBEF ');
      qryAux.SQL.Add('WHERE BEF_CFOPBF = :CFOPBF ');
      qryAux.SQL.Add('  AND BEF_CSTBEF = :CSTBEF ');
      qryAux.SQL.Add('  AND BEF_PERABR = :PERABR ');
      qryAux.SQL.Add('  AND BEF_CODEMP = :CODEMP ');
      qryAux.ParamByName('CFOPBF').AsString := ACfopBf;
      qryAux.ParamByName('CSTBEF').AsString := ACstBef;
      qryAux.ParamByName('PERABR').AsString := APerAbr;
      qryAux.ParamByName('CODEMP').AsString := ACodEmp;
      qryAux.ExecSQL;
    Except
      Result := False;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmCadBeneficioFiscal.fCadastraRegistros: Boolean;
begin
  Result := True;

  qryEmpresas.First;
  While not qryEmpresas.eof Do
  Begin
    If not fCadastraRegistro(qryTabela.FieldByName('BEF_CFOPBF').AsString,
                             qryTabela.FieldByName('BEF_CSTBEF').AsString,
                             qryTabela.FieldByName('BEF_PERABR').AsString,
                             qryTabela.FieldByName('BEF_DESBEF').AsString,
                             qryTabela.FieldByName('BEF_CODIGO').AsString,
                             qryEmpresas.FieldByName('EMP_CODEMP').AsString) Then
    Begin
      Result := False;
      Break;
    End;

    qryEmpresas.Next;
  End;
end;

function TfrmCadBeneficioFiscal.fCadastraRegistro(ACfopBf, ACstBef, APerAbr, ADescri, ACodBen, ACodEmp: String): Boolean;
var
  qryAux: TUniQuery;
begin
  Result := True;

  qryAux := fCriaQuery();

  Try
    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT * FROM CADBEF WHERE FALSE');
      qryAux.Open;

      qryAux.Append;
      qryAux.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADBEF', ACodEmp);
      qryAux.FieldByName('BEF_CFOPBF').AsString := ACfopBf;
      qryAux.FieldByName('BEF_CSTBEF').AsString := ACstBef;
      qryAux.FieldByName('BEF_PERABR').AsString := APerAbr;
      qryAux.FieldByName('BEF_DESBEF').AsString := ADescri;
      qryAux.FieldByName('BEF_CODIGO').AsString := ACodBen;
      qryAux.FieldByName('BEF_CODEMP').AsString := ACodEmp;
      qryAux.Post;
    Except
      Result := False;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

end.
