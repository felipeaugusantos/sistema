{***************************}
{* qryConGru -> CADGRU     *}
{* qryConFor -> CADFOR     *}
{* qryConMar -> CADMAR     *}
{************************JB*}
unit untDigGiroEstoque;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni,
  EditFocus, Mask, MaskEditFocus, DateUtils, Menus, QColorLabel, Windows,
  AppEvnts;

type
  TfrmDigGiroEstoque = class(TfrmPaiSimples)
    Label1: TLabel;
    Label2: TLabel;
    mskLinGru: TMaskEditFocus;
    edtCodFor: TEditFocus;
    Label3: TLabel;
    edtCodMar: TEditFocus;
    Label4: TLabel;
    edtDiaCom: TEditFocus;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtn;
    btnCancelaDados: TBitBtn;
    edtDesGru: TEditFocus;
    edtNomFor: TEditFocus;
    edtDesMar: TEditFocus;
    pnlFundo: TPanel;
    GroupBox4: TGroupBox;
    ColorLabel4: TColorLabel;
    edtFilGir: TEditFocus;
    chkExibItens: TCheckBox;
    chkArredQtdeSugest: TCheckBox;
    chkMultCompra: TCheckBox;
    rdgOpcGir: TRadioGroup;
    chkTdsLojas: TCheckBox;
    rdgOrdem: TRadioGroup;
    chkEstMin: TCheckBox;
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure rdgOpcGirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdgOrdemClick(Sender: TObject);
  private
    { Private declarations }
    qryConMar: TUniQuery;
    qryConGru: TUniQuery;
    qryConFor: TUniQuery;

    procedure pCarregaLinGru;
    procedure pCarregaFornecedor;
    procedure pCarregaMarca;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodGru  : String;
    strCodFor  : String;
    strCodMar  : String;
    intQtdDia  : Integer;
    intOpcGir  : Integer;
    blnConfirma: Boolean;
    blnAllIte  : Boolean;
    blnArredSug: Boolean;  // Arredonda quantidade de sugestão
    blnConsMCom: Boolean;  // Considera múltiplo de compra
    blnConsTLoj: Boolean;  // Considera todas as lojas somadas
    intOrdem   : Integer;  // Ordenação: 1-descricao e 2-marca+descricao
    blnConsEMin: Boolean;  // Considera estoque mínimo para sugestão
  end;

var
  frmDigGiroEstoque: TfrmDigGiroEstoque;

implementation

uses untPesqAux, untFuncoes, untfuncoesSimples, untModulo, DB, untMenuGirEst,
  untModuloSPR, untConstantes, untPaiCad, untAltPrecoGlobal,
  untModuloCadGru, untModuloCadFor, untModuloCadMar, untMenuPedCom;

{$R *.dfm}

{ TfrmCalculoGiro }

function TfrmDigGiroEstoque.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskLinGru) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskLinGru.Text)) Then
      Begin
        edtDesGru.Text := 'TODOS';
      End
      Else
      Begin
        pCarregaLinGru;
        If qryConGru.FieldByName('GRU_CODGRU').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Linha / Grupo não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodFor) Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
      Begin
        edtNomFor.Text := 'TODOS';
      End
      Else
      Begin
        pCarregaFornecedor;
        If qryConFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodMar) Then
    Begin
      If fEmptyStr(edtCodMar.Text) Then
      Begin
        edtDesMar.Text := 'TODOS';
      End
      Else
      Begin
        pCarregaMarca;
        If qryConMar.FieldByName('MAR_CODMAR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Marca não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtFilGir) Then
    Begin
      If Pos(edtFilGir.Text,'CST') <= 0  Then
      Begin
        fMensagem('','O campo Relatório deve ser (C)com Giro, (S)em Giro ou (T)odos!',['&O K'],0);
        Result := False;
      End;
    End

    Else If (Sender = edtDiaCom) Then
    Begin
      If fEmptyStr(edtDiaCom.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Quantidade de Dias deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If StrToInt(edtDiaCom.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'A Quantidade de Dias deve ser maior que Zero!', ['&O k']);
          Result := False;
        End
      End;
    End

  End;

  If Not Result Then
    Sender.SetFocus;
end;

procedure TfrmDigGiroEstoque.pCarregaLinGru;
begin
  pPesquisaLinGru(frmModuloCadGru.qryCadGru, qryConGru, mskLinGru.Text);
  With qryConGru Do
  Begin
    edtDesGru.Text := qryConGru.FieldByName('GRU_DESGRU').AsString;
  End;
end;

procedure TfrmDigGiroEstoque.pCarregaFornecedor;
begin
  pPesquisaCadFor(frmmoduloCadFor.qryCadFor, qryConFor, edtCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := qryConFor.FieldByName('FOR_NOMFOR').AsString;
  End;
end;

procedure TfrmDigGiroEstoque.pCarregaMarca;
begin
  pPesquisaCadMar(frmModuloCadMar.qryCadMar, qryConMar, edtCodMar.Text);
  With qryConMar Do
  Begin
    edtDesMar.Text := qryConMar.FieldByName('MAR_DESMAR').AsString;
  End;
end;

procedure TfrmDigGiroEstoque.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamposCon, stlCamIndCon, stlDesIndCon: TStringList;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    stlCamposCon := TStringList.Create;
    stlCamIndCon := TStringList.Create;
    stlDesIndCon := TStringList.Create;

    Key := #0;
    stlCamposCon.Add('GRU_DESGRU');
    stlCamposCon.Add('GRU_CODGRU');
    stlCamposCon.Add('AUTOINCREM');

    stlCamIndCon.Add('GRU_DESGRU');
    stlCamIndCon.Add('GRU_CODGRU');

    stlDesIndCon.Add('Descrição');
    stlDesIndCon.Add('Código');

    If pConsultaRapida(Self, qryConGru, 'CADGRU', stlCamIndCon,
      stlDesIndCon, stlCamposCon) Then
    Begin
      mskLinGru.Text := qryConGru.FieldByName('GRU_CODGRU').AsString;
      Self.SelectNext(ActiveControl, True, True);
    End;
    pCarregaLinGru;

    FreeAndNil(stlCamposCon);
    FreeAndNil(stlCamIndCon);
    FreeAndNil(stlDesIndCon);
  End;
end;

procedure TfrmDigGiroEstoque.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
  stlCamposCon, stlCamIndCon, stlDesIndCon: TStringList;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    stlCamposCon := TStringList.Create;
    stlCamIndCon := TStringList.Create;
    stlDesIndCon := TStringList.Create;

    Key := #0;
    stlCamposCon.Add('FOR_NOMFOR');
    stlCamposCon.Add('FOR_NOMFAN');
    stlCamposCon.Add('FOR_CODFOR');
    stlCamposCon.Add('AUTOINCREM');

    stlCamIndCon.Add('FOR_NOMFOR');
    stlCamIndCon.Add('FOR_NOMFAN');
    stlCamIndCon.Add('FOR_CODFOR');

    stlDesIndCon.Add('Nome');
    stlDesIndCon.Add('Nome Fantasia');
    stlDesIndCon.Add('Código');

    If pConsultaRapida(Self, qryConFor, 'CADFOR',
        stlCamIndCon, stlDesIndCon, stlCamposCon) Then
    Begin
      edtCodFor.Text := qryConFor.FieldByName('FOR_CODFOR').AsString;
      Self.SelectNext(ActiveControl, True, True);
    End;
    pCarregaFornecedor;

    FreeAndNil(stlCamposCon);
    FreeAndNil(stlCamIndCon);
    FreeAndNil(stlDesIndCon);
    
  End;

end;

procedure TfrmDigGiroEstoque.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
  Var
  stlCamposCon, stlCamIndCon, stlDesIndCon: TStringList;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    stlCamposCon := TStringList.Create;
    stlCamIndCon := TStringList.Create;
    stlDesIndCon := TStringList.Create;

    Key := #0;
    stlCamposCon.Add('MAR_DESMAR');
    stlCamposCon.Add('MAR_CODMAR');
    stlCamposCon.Add('AUTOINCREM');

    stlCamIndCon.Add('MAR_DESMAR');
    stlCamIndCon.Add('MAR_CODMAR');

    stlDesIndCon.Add('Descrição');
    stlDesIndCon.Add('Código');

    If pConsultaRapida(Self, qryConMar, 'CADMAR', stlCamIndCon,
      stlDesIndCon, stlCamposCon) Then
    Begin
      edtCodMar.Text := qryConMar.FieldByName('MAR_CODMAR').AsString;
      Self.SelectNext(ActiveControl, True, True);
    End;
    pCarregaMarca;

    FreeAndNil(stlCamposCon);
    FreeAndNil(stlCamIndCon);
    FreeAndNil(stlDesIndCon);
    
  End;

end;

procedure TfrmDigGiroEstoque.FormCreate(Sender: TObject);
  Var
    strPedMlj: String;
begin
  inherited;
  blnConfirma := False;

  qryConGru := frmModuloCadGru.qryCadGru;
  qryConFor := frmModuloCadFor.qryCadFor;
  qryConMar := frmModuloCadMar.qryCadMar;

  chkExibItens.Checked := True;

  If strPedMlj = 'S' Then
  Begin
    chkTdsLojas.Visible := False;
    chkTdsLojas.Checked := True;
  End;

end;

procedure TfrmDigGiroEstoque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fFecharTabela(qryConGru);
  fFecharTabela(qryConFor);
  fFecharTabela(qryConMar);
end;

procedure TfrmDigGiroEstoque.btnCancelaClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDigGiroEstoque.btnConfirmaDadosClick(Sender: TObject);
begin
  If fVerificaCampos Then
  Begin
    strCodGru := mskLinGru.Text;
    strCodFor := edtCodFor.Text;
    strCodMar := edtCodMar.Text;
    intQtdDia := StrToInt(edtDiaCom.Text);
    blnAllIte := chkExibItens.Checked;
    blnArredSug := chkArredQtdeSugest.Checked;
    blnConsMCom := chkMultCompra.Checked;
    blnConsTLoj := chkTdsLojas.Checked;
    blnConsEMin := chkEstMin.Checked;      
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmDigGiroEstoque.rdgOpcGirClick(Sender: TObject);
begin
  inherited;
  intOpcGir := rdgOpcGir.ItemIndex;
end;

procedure TfrmDigGiroEstoque.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: Close;
    VK_RETURN : If (ActiveControl Is TRadioButton) Then
                  SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigGiroEstoque.rdgOrdemClick(Sender: TObject);
begin
  inherited;
  intOrdem := rdgOrdem.ItemIndex;
end;

end.

