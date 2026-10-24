unit untFatItensNotaEntrada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatItensNotaEntrada = class(TfrmPaiConfirma)
    Label2: TLabel;
    edtNumDoc: TEditFocus;
    Label4: TLabel;
    edtSerie: TEditFocus;
    Label6: TLabel;
    lblCliFor: TLabel;
    edtCodCliFor: TEditFocus;
    edtNomCliFor: TEditFocus;
    lblCodEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    cbxEspDoc: TComboBox;
    rdgUtiPre: TRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliForKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbxEspDocChange(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    strCliForMens: String;
    function fDocumentoExiste(strNumDoc, strEspDoc, strSerie, strCodCliFor, strCodEmp: String): Boolean;
    function HabilitarOpcoesOutrasSaidas(const OutrasSaidas,
      AConsertoDeEquipamentos: Boolean): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnOutrasSaidas : Boolean;
    blnConEqu       : Boolean;
    blnDocumentoFornecedor: Boolean;
    qryItens: TUniQuery;
  end;

var
  frmFatItensNotaEntrada: TfrmFatItensNotaEntrada;

implementation

uses untFuncoesSimples, untConsultas, Data.DB, untTypesSistema;

{$R *.dfm}

procedure TfrmFatItensNotaEntrada.cbxEspDocChange(Sender: TObject);
begin
  inherited;
  If cbxEspDoc.Text = 'TE' Then
  Begin
    strCliForMens := 'Cliente';
    lblCliFor.Caption := strCliForMens + ':';
  End
  Else
  Begin
    strCliForMens := 'Fornecedor';
    lblCliFor.Caption := strCliForMens + ':';
  End;
end;

procedure TfrmFatItensNotaEntrada.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatItensNotaEntrada.edtNumDocKeyPress(Sender: TObject;var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  If (Not fCfgSis('ENTEST', varBoolean)) Then
    Exit;

  if fEntraCons(Key) then
  begin

    If (fPesqNotaDeEntradaOutrasSaidas('Consulta Nota de Entrada - Outras Saídas',
                                        Nil,
                                        cbxEspDoc.Text,
                                        edtNumDoc,
                                        edtSerie,
                                        edtCodCliFor,
                                        edtNomCliFor,
                                        Key,
                                        arrSel))Then
    Begin
      If fValidaCampos(edtNumDoc, True) Then
        SelectNext(ActiveControl, True, True);
    End;

  end;


end;

procedure TfrmFatItensNotaEntrada.edtCodCliForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
    blnAchouCliFor: Boolean;
begin
  inherited;
  If cbxEspDoc.Text = 'TE' Then
    blnAchouCliFor := fPesqCliente(conCliSimples, Self, edtCodCliFor, edtNomCliFor, Nil, Key, arrFornec)
  Else
    blnAchouCliFor := fPesqFornecedor(conForSimples, Self, edtCodCliFor, edtNomCliFor, Nil, Key, arrFornec);

  If blnAchouCliFor Then
  Begin
    If fValidaCampos(edtCodCliFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatItensNotaEntrada.fDocumentoExiste(strNumDoc,
   strEspDoc, strSerie, strCodCliFor, strCodEmp: String): Boolean;
  Var
    strTePrev,
    strPreIte: String;
Begin
  strTePrev := fGetTEPREV(VS_strCodEmp, fRetornaClienteFilial(strCodEmp));

  If SameText(strTePrev , 'IMP') Then
    strPreIte := 'ITE_IMPULT'
  Else If SameText(strTePrev , 'SIC') Then
    strPreIte := 'ITE_MEDSIC'
  Else
    strPreIte := 'ITE_PRE' + strTePrev;

  With qryItens, SQL Do
  Begin
    Clear;
    Close;
    Add('SELECT D.*, G.*, ' + strPreIte + ' AS PRECO_TE, "" AS DET_NCMITE FROM');
    Add('MOVDET D');
    Add('INNER JOIN ITEGER G ON G.ITE_CODITE = DET_CODITE AND G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp));
    Add('WHERE');

    Add('  DET_NUMDOC = :NUMDOC AND');
    Add('  DET_ESPDOC = :ESPDOC AND');
    Add('  DET_CODEMP = :CODEMP AND');
    If cbxEspDoc.Text = 'TE' Then
      Add('  DET_CODCLI = :CODCLIFOR AND')
    Else
      Add('  DET_CODFOR = :CODCLIFOR AND');

    Add('  IFNULL(DET_SERIE_, "") = :NUMSER');

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLIFOR').AsString := strCodCliFor;
    ParamByName('NUMSER').AsString := strSerie;

    Open;

    Result := Not IsEmpty;
  End;
End;

procedure TfrmFatItensNotaEntrada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin
    If Not fVerificaCampos Then
      Action := caNone;
  End;
end;

procedure TfrmFatItensNotaEntrada.FormCreate(Sender: TObject);
begin
  blnOutrasSaidas := false;
  blnConEqu       := false;
  inherited;
  strCliForMens := 'Fornecedor';

  qryItens := fCriaQuery(Self);

end;

procedure TfrmFatItensNotaEntrada.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If ActiveControl Is TComboBox Then
                 Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatItensNotaEntrada.HabilitarOpcoesOutrasSaidas(
Const OutrasSaidas : Boolean; Const AConsertoDeEquipamentos : Boolean)  : Boolean;
begin
  Result := false;

  if Not OutrasSaidas Then
    Exit;

  If AConsertoDeEquipamentos Then
    Exit;

  Result := true;
end;


procedure TfrmFatItensNotaEntrada.FormShow(Sender: TObject);
begin
  inherited;

  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;

  edtNumDoc.TamCampo  := fTamNumDoc;
  edtNumDoc.MaxLength := edtNumDoc.TamCampo;

  rdgUtiPre.ItemIndex := 0;
  rdgUtiPre.Controls[0].Enabled := true;
  rdgUtiPre.Controls[1].Enabled := true;
  rdgUtiPre.Controls[2].Enabled := blnDocumentoFornecedor;

  If HabilitarOpcoesOutrasSaidas(blnOutrasSaidas, blnConEqu) Then
  begin
    rdgUtiPre.Controls[0].Enabled := false;
    rdgUtiPre.Controls[1].Enabled := false;
    rdgUtiPre.Controls[2].Enabled := true;

    rdgUtiPre.ItemIndex := 2;
  end;

  pSetFocus(edtNumDoc);
end;

function TfrmFatItensNotaEntrada.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número do Documento deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtSerie) Then
    Begin

    End

    Else If (Sender = edtCodCliFor) Then
    Begin

      If fEmptyStr(edtCodCliFor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do ' + strCliForMens + ' deve ser preenchido!', ['&O k']);
        edtNomCliFor.Clear;
        Result := False;
      End Else
      Begin
        If cbxEspDoc.Text = 'TE' Then
          edtNomCliFor.Text := fRetNomCliente(edtCodCliFor.Text)
        Else
          edtNomCliFor.Text := fRetNomFornecedor(edtCodCliFor.Text);

        If fEmptyStr(edtNomCliFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', strCliForMens + ' não encontrado!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
        edtNomEmp.Clear;
        Result := False;
      End Else
      Begin

        edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&O k']);
          Result := False;
        End

        Else If Not fDocumentoExiste(edtNumDoc.Text,
                                     cbxEspDoc.Text,
                                     edtSerie.Text,
                                     edtCodCliFor.Text,
                                     edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Documento não encontrado!', ['&O k']);
          Result := False;
        End;

      End;

    End


  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
