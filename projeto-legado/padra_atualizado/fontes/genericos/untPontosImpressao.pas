unit untPontosImpressao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, Grids, DBGridCitel, DBGrids, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, DB, Uni, BitBtnLockedIncrem, untFuncoesSimples;

type
  TfrmPontosImpressao = class(TfrmPaiSimples)
    dbgPonImp: TDBGridCitel;
    dtsPonImp: TDataSource;
    procedure dbgPonImpKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    qryPon   : TUniQuery;
    strPonImp: String;
  end;

var
  frmPontosImpressao: TfrmPontosImpressao;

implementation

uses untPai;

{$R *.dfm}

procedure TfrmPontosImpressao.dbgPonImpKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (key = VK_RETURN) Then
  Begin
    strPonImp := qryPon.FieldByName('PON_NOMPON').AsString;
//    FreeAndNil(qryPon); É LIBERADO ONDE CRIOU
    ModalResult := mrOk;
  End;

end;

procedure TfrmPontosImpressao.FormActivate(Sender: TObject);
Const
  intFrmGravandoMeioWidth = 254;
  intBarraTarefasHeigth   = 40;
begin
  inherited;

  Self.Left := Round(Screen.Monitors[0].Width / 2) + intFrmGravandoMeioWidth;
  Self.Top  := Round((Screen.Monitors[0].Height - intBarraTarefasHeigth) / 2) - Round(Self.Height / 2);
end;

procedure TfrmPontosImpressao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If (ModalResult <> mrOk) Then
    Action := caNone
  Else
    inherited;

end;

procedure TfrmPontosImpressao.FormCreate(Sender: TObject);
begin
  inherited;

  If RunningInTSPlus Then
    Self.FormStyle := fsStayOnTop;
end;

procedure TfrmPontosImpressao.FormShow(Sender: TObject);
begin
  inherited;

  dtsPonImp.DataSet    := qryPon;
  dbgPonImp.DataSource := dtsPonImp;
  qryPon.Open;

  pnlInfo.Caption := 'Tecle Enter ao escolher';
end;

end.
