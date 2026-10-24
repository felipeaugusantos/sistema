unit untCtrSelClienteImp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid, UniClientDataSet,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, System.StrUtils,
  frxClass, frxExportCSVTestabilidade, Datasnap.DBClient,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCtrSelClienteImp = class(TfrmPaiEdit)
    pnl1: TPanel;
    cxgSelCliDBTableView1: TcxGridDBTableView;
    cxgSelCliLevel1: TcxGridLevel;
    cxgSelCli: TcxGrid;
    cxGridCODCLI: TcxGridDBColumn;
    cxGridNOMCLI: TcxGridDBColumn;
    cxGridQTDTIT: TcxGridDBColumn;
    cxGridVALDUP: TcxGridDBColumn;
    cxGridVALCOR: TcxGridDBColumn;
    dtsSelCli: TDataSource;
    cdsSelCli: TUniClientDataSet;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxGridMARDES: TcxGridDBColumn;
    lbl1: TLabel;
    btnConfirma: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarTodos: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure cxgSelCliDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgSelCliDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarTodosClick(Sender: TObject);
  private
    procedure pDesmarcaTodos;
    procedure pMarcaTodos;
    { Private declarations }
  public
    blnConfirma: Boolean;
    bVerificarEmail : Boolean;
    blnCartaCob: Boolean;
  end;

var
  frmCtrSelClienteImp: TfrmCtrSelClienteImp;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmCtrSelClienteImp.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
  Close;
end;

procedure TfrmCtrSelClienteImp.btnDesmarTodosClick(Sender: TObject);
begin
  inherited;
  pDesmarcaTodos;
end;

procedure TfrmCtrSelClienteImp.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaTodos;
end;

procedure TfrmCtrSelClienteImp.cxgSelCliDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strMarDes: String;
begin
  inherited;
  strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridMARDES.Index]);
  If (strMarDes = 'M') Then
    ACanvas.Font.Color := clBlue
  Else
    ACanvas.Font.Color := clBlack;
end;

procedure TfrmCtrSelClienteImp.cxgSelCliDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    With cdsSelCli Do
    Begin
      If (bVerificarEmail = True) and (FieldByName('MARDES').AsString = 'D')
      and (IfNull(FieldByName('CLI_EMAIL_').AsString, '') = '')  then
        fMensagem('ATENÇÃO!', 'Cliente sem e-mail cadastrado para envio!', ['&O k'])
      else
      Begin
        Edit;
        FieldByName('MARDES').AsString := IfThen(FieldByName('MARDES').AsString = 'M', 'D', 'M');
        Post;
      End;
    End;
  End
  Else If (Key = VK_F7) Then
    pMarcaTodos

  Else If (Key = VK_F8) Then
    pDesmarcaTodos;
    
end;

procedure TfrmCtrSelClienteImp.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmCtrSelClienteImp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F10) Then
    btnConfirma.Click;

end;

procedure TfrmCtrSelClienteImp.FormShow(Sender: TObject);
begin
  inherited;
  if blnCartaCob then
  Begin
    If not fCfgSis('RECCOB', varBoolean) Then
    Begin
      cxGridVALCOR.Visible := false;
    end;
  end;

  pSetFocus(cxgSelCli);
end;

procedure TfrmCtrSelClienteImp.pMarcaTodos;
begin

  With cdsSelCli Do
  Begin
    DisableControls;
    First;

    While Not Eof Do
    Begin
      If (bVerificarEmail = TRUE) then
      Begin
        If (IfNull(FieldByName('CLI_EMAIL_').AsString, '') <> '') then
        Begin
          Edit;
          FieldByName('MARDES').AsString := 'M';
          Post;
        End;
      End else
      Begin
        Edit;
        FieldByName('MARDES').AsString := 'M';
        Post;
      End;

      Next;
    End;

    First;
    EnableControls;
  End;
  
end;

procedure TfrmCtrSelClienteImp.pDesmarcaTodos;
begin

  With cdsSelCli Do
  Begin
    DisableControls;
    First;

    While Not Eof Do
    Begin
      Edit;
      FieldByName('MARDES').AsString := 'D';
      Post;

      Next;
    End;

    First;
    EnableControls;
  End;

end;

end.
