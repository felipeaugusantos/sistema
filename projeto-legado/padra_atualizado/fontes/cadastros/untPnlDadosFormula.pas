unit untPnlDadosFormula;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, UniClientDataSet,
  Vcl.Buttons, BitBtnLockedIncrem;

type
  TfrmPnlDadosFormula = class(TForm)
    Label1: TLabel;
    lblObs001: TLabel;
    lblObs002: TLabel;
    lblObs004: TLabel;
    lblObs003: TLabel;
    lblObs005: TLabel;
    lblObs007: TLabel;
    lblObs006: TLabel;
    Panel1: TPanel;
    shpRed: TShape;
    Label2: TLabel;
    shpBlk: TShape;
    lblAtivas: TLabel;
    pnlCadFormula: TPanel;
    btnCadFormula: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnCadFormulaClick(Sender: TObject);
  private
    { Private declarations }
  public
    FConfirma : TBitBtnLocked;
    cdsConsulta: TUniClientDataSet;
    procedure pIniciouNavegacaoGridConsulta;
    procedure pParouNavegacaoGridConsulta;
  end;
  TfrmPnlDadosFormulaClass = Class Of TfrmPnlDadosFormula;

var
  frmPnlDadosFormula: TfrmPnlDadosFormula;

implementation

uses
  untCadEstruturasIndustrial, untFuncoesSimples;

{$R *.dfm}

{ TfrmPnlDadosFormula }

procedure TfrmPnlDadosFormula.btnCadFormulaClick(Sender: TObject);
var
  frmCadEstruturasIndustrial: TfrmCadEstruturasIndustrial;
begin
  pCriarFormularios(TfrmCadEstruturasIndustrial, frmCadEstruturasIndustrial);

  Try
    frmCadEstruturasIndustrial.pCarregaFormula(cdsConsulta.FieldByName('GMT_CODITE').AsString,
                                               cdsConsulta.FieldByName('COR_CODCOR').AsString,
                                               cdsConsulta.FieldByName('GMT_FORMUL').AsString);

    FConfirma.Click;
  Finally
    FreeAndNil(frmCadEstruturasIndustrial);
  End;
end;

procedure TfrmPnlDadosFormula.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_F1: If pnlCadFormula.Visible Then
             btnCadFormula.Click;
  End;
end;

procedure TfrmPnlDadosFormula.FormShow(Sender: TObject);
begin
  if not pnlCadFormula.Visible Then
    Self.Height := Self.Height - pnlCadFormula.Height;
end;

procedure TfrmPnlDadosFormula.pIniciouNavegacaoGridConsulta;
begin
  if (Not Assigned(lblObs001)) or (not Assigned(cdsConsulta)) then
    Exit;

  lblObs001.Caption := 'Atualizando...';
  lblObs002.Caption := 'Atualizando...';
  lblObs003.Caption := 'Atualizando...';
  lblObs004.Caption := 'Atualizando...';
  lblObs005.Caption := 'Atualizando...';
  lblObs006.Caption := 'Atualizando...';
  lblObs007.Caption := 'Atualizando...';
end;

procedure TfrmPnlDadosFormula.pParouNavegacaoGridConsulta;
begin
  If (Not Self.Showing) Then
    Exit;

  if (Not Assigned(lblObs001)) or (not Assigned(cdsConsulta)) then
    Exit;

  lblObs001.Caption := cdsConsulta.FieldByName('GMT_OBS001').AsString;
  lblObs002.Caption := cdsConsulta.FieldByName('GMT_OBS002').AsString;
  lblObs003.Caption := cdsConsulta.FieldByName('GMT_OBS003').AsString;
  lblObs004.Caption := cdsConsulta.FieldByName('GMT_OBS004').AsString;
  lblObs005.Caption := cdsConsulta.FieldByName('GMT_OBS005').AsString;
  lblObs006.Caption := cdsConsulta.FieldByName('GMT_OBS006').AsString;
  lblObs007.Caption := cdsConsulta.FieldByName('GMT_OBS007').AsString;
end;

end.




