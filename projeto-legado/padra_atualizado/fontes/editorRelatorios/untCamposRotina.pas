unit untCamposRotina;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid,
  untFuncoesSimples, untRotinasGrid;

type
  TfrmCamposRotina = class(TfrmPaiEdit)
    pnlRotina: TPanel;
    cxvCampos: TcxGridDBTableView;
    cxgCamposLevel1: TcxGridLevel;
    cxgCampos: TcxGrid;
    cxvCamposColumn1: TcxGridDBColumn;
    cxvCamposColumn2: TcxGridDBColumn;
    cxvCamposColumn3: TcxGridDBColumn;
    cxStyleRepository: TcxStyleRepository;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle1: TcxStyle;
    cxStyle5: TcxStyle;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    objRotinasGrid: TRotinasGrid;

    Class Procedure pMostraCamposRotina(objRotinasGrid: TRotinasGrid);
  end;

var
  frmCamposRotina: TfrmCamposRotina;

implementation

{$R *.dfm}

procedure TfrmCamposRotina.FormShow(Sender: TObject);
begin
  inherited;

  cxvCampos.DataController.DataSource := objRotinasGrid.cdsCamposRotina.dtsSource;
end;

Class Procedure TfrmCamposRotina.pMostraCamposRotina(objRotinasGrid: TRotinasGrid);
  Var
    frmCamposRotina: TfrmCamposRotina;
Begin
  Try
    Try
      If fEmptyStr(objRotinasGrid.cdsRotinasRelatorio.FieldByName('ROT_NOMROT').AsString) Then
        Exit;

      objRotinasGrid.pFiltraCamposRotina(objRotinasGrid.cdsRotinasRelatorio.FieldByName('ROT_NOMROT').AsString);

      If objRotinasGrid.cdsCamposRotina.IsEmpty Then
      Begin
        pMensagemOk('Essa rotina não possui campos obrigatórios!');

        Exit;
      End;

      pCriarFormularios(TfrmCamposRotina, frmCamposRotina);

      frmCamposRotina.pnlRotina.Caption := 'Rotina ' + objRotinasGrid.cdsRotinasRelatorio.FieldByName('DESROT').AsString;

      frmCamposRotina.objRotinasGrid := objRotinasGrid;

      frmCamposRotina.ShowModal;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmCamposRotina.pMostraCamposRotina]');
      End;
    End;

    FreeAndNil(frmCamposRotina)

  Finally
    objRotinasGrid.cdsCamposRotina.Filtered := False;
  End;
End;

end.
