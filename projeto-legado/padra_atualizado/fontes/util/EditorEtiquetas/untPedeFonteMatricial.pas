unit untPedeFonteMatricial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, cxStyles, cxGraphics, cxEdit, cxControls,
  cxInplaceContainer, cxVGrid, cxCheckBox,
  untFuncoesEditorFast, cxLookAndFeels, cxLookAndFeelPainters;

type
  TfrmPedeFonteMatricial = class(TfrmPaiConfirma)
    cxvFonte: TcxVerticalGrid;
    cxvFonteNegrito: TcxEditorRow;
    cxvFonteItalico: TcxEditorRow;
    cxvFonteSuperScript: TcxEditorRow;
    cxvFonteSubScript: TcxEditorRow;
    cxvFonteCondensado: TcxEditorRow;
    cxvFonteExpandido: TcxEditorRow;
    cxvFonte12Cpi: TcxEditorRow;
    cxvFonte15cpi: TcxEditorRow;
    cxvFonteWide: TcxEditorRow;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxvFonteSuperScriptEditPropertiesChange(Sender: TObject);
    procedure cxvFonteSubScriptEditPropertiesChange(Sender: TObject);
    procedure cxvFonteCondensadoEditPropertiesChange(Sender: TObject);
    procedure cxvFonteExpandidoEditPropertiesChange(Sender: TObject);
    procedure cxvFonte12CpiEditPropertiesChange(Sender: TObject);
    procedure cxvFonte15cpiEditPropertiesChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    recFonMat: TRecFonteMatricial;
  end;

var
  frmPedeFonteMatricial: TfrmPedeFonteMatricial;

implementation

{$R *.dfm}

procedure TfrmPedeFonteMatricial.cxvFonte12CpiEditPropertiesChange(
  Sender: TObject);
begin
  inherited;

  If cxvFonte12Cpi.Properties.Value Then
    cxvFonte15cpi.Properties.Value := False;

end;

procedure TfrmPedeFonteMatricial.cxvFonte15cpiEditPropertiesChange(
  Sender: TObject);
begin
  inherited;

  If cxvFonte15Cpi.Properties.Value Then
    cxvFonte12cpi.Properties.Value := False;

end;

procedure TfrmPedeFonteMatricial.cxvFonteCondensadoEditPropertiesChange(
  Sender: TObject);
begin
  inherited;

  If cxvFonteCondensado.Properties.Value Then
    cxvFonteExpandido.Properties.Value := False;

end;

procedure TfrmPedeFonteMatricial.cxvFonteExpandidoEditPropertiesChange(
  Sender: TObject);
begin
  inherited;

  If cxvFonteExpandido.Properties.Value Then
    cxvFonteCondensado.Properties.Value := False;

end;

procedure TfrmPedeFonteMatricial.cxvFonteSubScriptEditPropertiesChange(
  Sender: TObject);
begin
  inherited;

  If cxvFonteSubScript.Properties.Value Then
    cxvFonteSuperScript.Properties.Value := False;

end;

procedure TfrmPedeFonteMatricial.cxvFonteSuperScriptEditPropertiesChange(
  Sender: TObject);
begin
  inherited;

  If cxvFonteSuperScript.Properties.Value Then
    cxvFonteSubScript.Properties.Value := False;
end;

procedure TfrmPedeFonteMatricial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    With recFonMat Do
    Begin
      blnNegrito     := cxvFonteNegrito.Properties.Value;
      blnItalico     := cxvFonteItalico.Properties.Value;
      blnSuperScript := cxvFonteSuperScript.Properties.Value;
      blnSubScript   := cxvFonteSubScript.Properties.Value;
      blnCondensado  := cxvFonteCondensado.Properties.Value;
      blnExpandido   := cxvFonteExpandido.Properties.Value;
      bln12cpi       := cxvFonte12Cpi.Properties.Value;
      bln15cpi       := cxvFonte15cpi.Properties.Value;
      blnWide        := cxvFonteWide.Properties.Value;
    End;

  End;
end;

procedure TfrmPedeFonteMatricial.FormShow(Sender: TObject);
begin
  inherited;

  With recFonMat Do
  Begin
    cxvFonteNegrito.Properties.Value     := blnNegrito;
    cxvFonteItalico.Properties.Value     := blnItalico;
    cxvFonteSuperScript.Properties.Value := blnSuperScript;
    cxvFonteSubScript.Properties.Value   := blnSubScript;
    cxvFonteCondensado.Properties.Value  := blnCondensado;
    cxvFonteExpandido.Properties.Value   := blnExpandido;
    cxvFonte12Cpi.Properties.Value       := bln12cpi;
    cxvFonte15cpi.Properties.Value       := bln15cpi;
    cxvFonteWide.Properties.Value        := blnWide;
  End;

end;

end.
