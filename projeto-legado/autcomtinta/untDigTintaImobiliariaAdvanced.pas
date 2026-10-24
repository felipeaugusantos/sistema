unit untDigTintaImobiliariaAdvanced;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untDigTintaIndustrial , AppEvnts, Menus, StdCtrls, EditFocus,
  Buttons, ExtCtrls, Uni, DB, untDigTintaImobiliaria;

type
  TfrmDigTintaImobiliariaAdvanced = class(TfrmDigTintaIndustrial)
    procedure btnFormulacaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNovBasKeyPress(Sender: TObject; var Key: Char);
  private
    procedure pCarregarComponenteB;
    procedure pCarregarPreco;
    { Private declarations }
  protected
    procedure pCalculaTotais; override; 
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmDigTintaImobiliariaAdvanced: TfrmDigTintaImobiliariaAdvanced;

implementation

uses untFuncoesSimples,
  untFuncEspecificas, untAdvancedIndustrialDinamica,
  untFormulacaoImobiliaria;

{$R *.dfm}

procedure TfrmDigTintaImobiliariaAdvanced.btnFormulacaoClick(
  Sender: TObject);
begin
  Application.CreateForm(TfrmFormulacaoImobiliaria , frmFormulacaoImobiliaria);
  frmFormulacaoImobiliaria.objFormula := objFormula;
  frmFormulacaoImobiliaria.Caption := frmFormulacaoImobiliaria.Caption + objFormula.strDescri;
  frmFormulacaoImobiliaria.ShowModal;
  FreeAndNil(frmFormulacaoImobiliaria);
end;

procedure TfrmDigTintaImobiliariaAdvanced.pCarregarComponenteB;
begin
  edtBasB.Text := TFormulaAdvanced(objFormula).strCompB;
  edtDesBasB.Text := fRetNomProduto(edtBasB.Text);
end;

procedure TfrmDigTintaImobiliariaAdvanced.FormShow(Sender: TObject);
begin
  inherited;
  pCarregarComponenteB;
  pCarregarPreco;
end;

procedure TfrmDigTintaImobiliariaAdvanced.pCarregarPreco;
begin
  edtPreBasB.Text := FormatFloat('0.00', TFormulaAdvanced(objFormula).fltVenBasB );
end;

procedure TfrmDigTintaImobiliariaAdvanced.edtNovBasKeyPress(
  Sender: TObject; var Key: Char);
begin
//  inherited;
end;

function TfrmDigTintaImobiliariaAdvanced.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtBasB) Then
  Begin

    If (fEmptyStr(edtBasB.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A nova base deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
//      pCarregaNovaBase;
      If qryNovBas.IsEmpty Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End
      Else If qryNovBas.FieldByName('ITE_ITEBAS').AsString <> 'S' Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não é uma Base!', ['&Ok']);
        Result := False;
      End
//      Else If Not SameText(qryNovBas.FieldByName('UNI_SIGUNI').AsString, qryBasAtu.FieldByName('UNI_SIGUNI').AsString) Then
//      Begin
//        fMensagem('ATENÇÃO!', 'A Sigla da Unidade da nova base deve ser a mesma da base atual!', ['&Ok']);
//        Result := False;
//      End
      Else
      Begin
        objFormula.strIteBas := edtBasB.Text;
        edtPreBasB.Text := FloatToStrF(objFormula.fltVenBas , ffFixed, 12, 2);
        pCalculaTotais;
      End;
    End;

  End;
end;

procedure TfrmDigTintaImobiliariaAdvanced.pCalculaTotais;
begin
  Try
    objFormula.pCalculaPreco;
  Except
    On E: Exception Do
    Begin
      fMensagem('ATENÇÃO!', E.Message, ['&Ok']);
    End;
  End;

  edtValBas.Text := FloatToStrF(objFormula.fltVenBas + objFormula.fltVenBasOri, ffFixed, 12, 2);
  edtValCol.Text := FloatToStrF(objFormula.fltVenCol, ffFixed, 12, 2);
  edtValTin.Text := FloatToStrF(objFormula.fltPreVen, ffFixed, 12, 2);
end;

end.
