unit untPedePendenciasNota;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox,
  untPendenciaFiscal;

type
  TfrmPedePendenciasNota = class(TfrmPaiConfirma)
    cxvPendencias: TcxGridDBTableView;
    cxgPendenciasLevel1: TcxGridLevel;
    cxgPendencias: TcxGrid;
    cxvPendenciasMarcado: TcxGridDBColumn;
    cxvPendenciasColumn2: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxvPendenciasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    objPendencia: TPendenciaFiscal;
  public
    { Public declarations }
    blnSoConsulta: Boolean;
    srtAutXMLVAL: String;
  end;

var
  frmPedePendenciasNota: TfrmPedePendenciasNota;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmPedePendenciasNota.cxvPendenciasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: Close;
  End;
end;

procedure TfrmPedePendenciasNota.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin
    If fPergunta('Confirma a gravação dos motivos?') Then
      If objPendencia.fGravaPendenciasNota(srtAutXMLVAL) Then
        pMensagemOk('Motivos gravados com sucesso!')
      Else
        Action := caNone;

  End Else If Not blnSoConsulta Then
  Begin
    If  Not fPergunta('Deseja abandonar a tarefa?') Then
      Action := caNone;
  End;
end;

procedure TfrmPedePendenciasNota.FormCreate(Sender: TObject);
begin
  inherited;

  blnSoConsulta := False;
  objPendencia := TPendenciaFiscal.Create(Self);
  cxvPendencias.DataController.DataSource := objPendencia.dtsSource;
end;

procedure TfrmPedePendenciasNota.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirma.Click;
  End;
end;

procedure TfrmPedePendenciasNota.FormShow(Sender: TObject);
begin
  inherited;

  cxvPendenciasMarcado.Visible := Not blnSoConsulta;
  btnConfirma.Visible          := Not blnSoConsulta;

  If blnSoConsulta Then
    btnSair.Caption := '&Sair';

  objPendencia.fCarregaPendenciasNota(srtAutXMLVAL, blnSoConsulta);
end;

end.
