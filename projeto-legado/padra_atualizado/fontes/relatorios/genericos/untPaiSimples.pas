unit untPaiSimples;
  
interface

uses
  Windows, SysUtils, Types, Classes, Variants,  Forms, Menus, ComCtrls, StdCtrls,
  Buttons, Controls, ExtCtrls, Graphics, Dialogs, untPai, Uni, Mask, FilenameEditFocus,
  AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmPaiSimples = class(TfrmPai)
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  protected
    strNomeTabela: String;
    qryTabela: TUniQuery;
    procedure pInicializaIndices; virtual;
//    procedure pEscapePressed; virtual;

//    procedure pOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); override;
//    procedure pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState); override;
  public
    { Public declarations }
  end;

var
  frmPaiSimples: TfrmPaiSimples;

implementation

{$R *.dfm}

{ TfrmPaiSimples }

procedure TfrmPaiSimples.pInicializaIndices;
begin
  inherited;
  // Apenas para sobrescrever a procedure.....
end;

procedure TfrmPaiSimples.FormShow(Sender: TObject);
begin
  // Apenas para sobrescrever a procedure.....
end;

procedure TfrmPaiSimples.btnSairClick(Sender: TObject);
begin
  Close;
end;

{procedure TfrmPaiSimples.pOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Return) Then
  Begin
    SelectNext(ActiveControl, True, True);
  End
  Else If (Key = VK_Escape) Then
  Begin
    pEscapePressed;
  End;
end;}

{procedure TfrmPaiSimples.pOnKeyDownEdits(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_Return) Then
  Begin
    If (Sender As TWinControl).Tag = 99 Then
    Begin
      If (fValidaCampos(TWinControl(Sender))) And (blnMudarFoco) Then
        SelectNext(ActiveControl, True, True);
    End
    Else
      SelectNext(ActiveControl, True, True);
    blnMudarFoco := True;
  End
  Else If (Key = VK_Escape) Then
  Begin
    pEscapePressed;
  End;
end;}

//procedure TfrmPaiSimples.pEscapePressed;
//begin
//  Close;
//end;

procedure TfrmPaiSimples.btnCancelaClick(Sender: TObject);
begin
//  Close;
end;

procedure TfrmPaiSimples.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //
end;

end.

