unit untCadMetasVendedorAtividadeHeranca;

interface

uses
  Windows, Classes, Controls, untPai, AppEvnts, Menus, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, EditFocus, Mask, MaskEditFocus, UniClientDataSet, Uni;

type
  TfrmCadMetasVendedorAtividadeHeranca = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTop: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    mskPeriodo: TMaskEditFocus;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    Label4: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = False): Boolean; override;
    { Private declarations }
  public
    cdsDados: TUniClientDataSet;
    class function fGetHeranca(Out oleDados: OleVariant): Boolean;
  end;

var
  frmCadMetasVendedorAtividadeHeranca: TfrmCadMetasVendedorAtividadeHeranca;

implementation

uses SysUtils, Forms, DB, untSQLRepositorio, untFuncoesSimples, untConsultas,
  untTypesSistema;

{$R *.dfm}

procedure TfrmCadMetasVendedorAtividadeHeranca.btnAdicionarClick(Sender: TObject);
  Var
    qryMet: TUniQuery;
begin
  If Not fVerificaCampos Then
    Exit;

  qryMet := fCriaQuery;
  Try
    pSQL(qryMet, repFaturamento, 'METATI_SELECT',
         [edtCodVen.Text,
          StrToDate('01/' + mskPeriodo.Text),
          edtCodEmp.Text]);
    qryMet.Open;

    If qryMet.IsEmpty Then
      pMensagemOk('Não foram encontrados registros com os dados informados!')
    Else
    Begin
      // Popula dataset conforme tela de metas
      qryMet.First;
      While Not qryMet.Eof Do
      Begin
        cdsDados.Append;
        cdsDados.FieldByName('CODATI').AsString := qryMet.FieldByName('MAT_CODATI').AsString;
        cdsDados.FieldByName('DESCRI').AsString := qryMet.FieldByName('MAT_CODATI').AsString +'-'+ fRetAtividade(qryMet.FieldByName('MAT_CODATI').AsString);
        cdsDados.FieldByName('PRAMED').AsFloat  := qryMet.FieldByName('MAT_PRAMED').AsFloat;
        cdsDados.FieldByName('FATURA').AsFloat  := qryMet.FieldByName('MAT_FATURA').AsFloat;
        cdsDados.FieldByName('MARGEM').AsFloat  := qryMet.FieldByName('MAT_MARGEM').AsFloat;
        cdsDados.Post;

        qryMet.Next;
      End;    
      ModalResult := mrOk;
    End;
  Finally
    qryMet.Free;
  End;
end;

procedure TfrmCadMetasVendedorAtividadeHeranca.FormActivate(Sender: TObject);
begin
  pSetFocus(edtCodVen);
end;

procedure TfrmCadMetasVendedorAtividadeHeranca.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados := TUniClientDataSet.Create(Nil);
  cdsDados.FieldDefs.Add('CODATI', ftString, 3);
  cdsDados.FieldDefs.Add('DESCRI', ftString, 70);
  cdsDados.FieldDefs.Add('PRAMED', ftFloat);
  cdsDados.FieldDefs.Add('FATURA', ftFloat);
  cdsDados.FieldDefs.Add('MARGEM', ftFloat);

  cdsDados.CreateDataSet;

  TFloatField(cdsDados.FieldByName('PRAMED')).DisplayFormat := '#,##0.00';
  TFloatField(cdsDados.FieldByName('FATURA')).DisplayFormat := '#,##0.00';
  TFloatField(cdsDados.FieldByName('MARGEM')).DisplayFormat := '#,##0.00';
end;

procedure TfrmCadMetasVendedorAtividadeHeranca.FormDestroy(Sender: TObject);
begin
  cdsDados.Free;
  inherited;
end;

function TfrmCadMetasVendedorAtividadeHeranca.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    strMsg: String;
begin
  strMsg := '';

  If Sender = edtCodVen Then
  Begin
    If fEmptyStr(edtCodVen.Text) Then
      strMsg := 'Vendedor deve ser preenchido!'
    Else
    Begin
      edtNomVen.Text := fRetNomeOperador(edtCodVen.Text);

      If fEmptyStr(edtNomVen.Text) Then
        strMsg := 'Vendedor não encontrado!';
    End;
  End

  Else If Sender = mskPeriodo Then
  Begin
    If fEmptyStr(mskPeriodo.Text, True) Then
      strMsg := 'Período deve ser preenchido!'
    Else If StrToDateDef('01/' + mskPeriodo.Text, 0) = 0 Then
      strMsg := 'Período inválido!';
  End

  Else If Sender = edtCodEmp Then
  Begin
    If fEmptyStr(edtCodEmp.Text) Then
      strMsg := 'Código da Empresa deve ser preenchido!'
    Else
    Begin
      edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

      If fEmptyStr(edtDesEmp.Text) Then
        strMsg := 'Código da Empresa não encontrado!';
    End;
  End;

  Result := fEmptyStr(strMsg);

  If Not Result Then
  Begin
    pMensagemOk(strMsg);
    pSetFocus(Sender);
  End;
end;

procedure TfrmCadMetasVendedorAtividadeHeranca.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      pSelNext;
  End;
end;

procedure TfrmCadMetasVendedorAtividadeHeranca.edtCodVenKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqOperador(Self, edtCodVen, edtNomVen, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodVen) Then
      pSelNext;
  End;
end;

class function TfrmCadMetasVendedorAtividadeHeranca.fGetHeranca(out oleDados: OleVariant): Boolean;
begin
  pCriarFormularios(TfrmCadMetasVendedorAtividadeHeranca, frmCadMetasVendedorAtividadeHeranca);
  Try
    Result := True;
    If frmCadMetasVendedorAtividadeHeranca.ShowModal = mrOk Then
      oleDados := frmCadMetasVendedorAtividadeHeranca.cdsDados.Data
    Else
      Result := False;

  Finally
    pFreeAndNil(frmCadMetasVendedorAtividadeHeranca);
  End;
end;

end.
