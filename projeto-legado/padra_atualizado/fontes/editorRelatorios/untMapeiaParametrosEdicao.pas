unit untMapeiaParametrosEdicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxDBLookupComboBox, cxCheckBox,
  untFuncoesSimples, untRotinasGrid;

type
  TfrmMapeiaParametrosEdicao = class(TfrmPaiConfirma)
    cxvParametros: TcxGridDBTableView;
    cxgParametrosLevel1: TcxGridLevel;
    cxgParametros: TcxGrid;
    cxvParametrosNOMPAR: TcxGridDBColumn;
    cxvParametrosDESPAR: TcxGridDBColumn;
    cxvParametrosEXIBIR: TcxGridDBColumn;
    cxvParametrosEDITAV: TcxGridDBColumn;
    cxvParametrosTIPATR: TcxGridDBColumn;
    cxvParametrosVALORC: TcxGridDBColumn;
    cxvParametrosPARPAI: TcxGridDBColumn;
    cxvParametrosNOMCAM: TcxGridDBColumn;
    cxStyleRepository: TcxStyleRepository;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle1: TcxStyle;
    cxStyle5: TcxStyle;
    pnlRotina: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    objRotinasGrid: TRotinasGrid;

    Class Procedure pCarregaParametrosBotao(objRotinasGrid: TRotinasGrid);
  end;

var
  frmMapeiaParametrosEdicao: TfrmMapeiaParametrosEdicao;

implementation

{$R *.dfm}

Uses
  untFuncoesRel,
  untInterfaceRelatorio;

procedure TfrmMapeiaParametrosEdicao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If Not objRotinasGrid.objMapeiaParametros.fValidaMapeamento(False) Then
    Begin
      Action := caNone;
      Exit;
    End;

  End Else
  Begin

    If Not fPergunta('Deseja abandonar a tafera sem salvar as alterações?') Then
    Begin
      Action := caNone;
      Exit;
    End;

  End;

end;

procedure TfrmMapeiaParametrosEdicao.FormShow(Sender: TObject);
begin
  inherited;

  cxvParametros.DataController.DataSource := objRotinasGrid.objMapeiaParametros.dtsSource;

  TcxLookupComboBoxProperties(cxvParametrosTIPATR.Properties).ListSource := objRotinasGrid.objMapeiaParametros.cdsTipoAtribuicao.dtsSource;
  TcxLookupComboBoxProperties(cxvParametrosPARPAI.Properties).ListSource := TInterfaceRelatorio(objRotinasGrid.objInteface).cdsParams.dtsSource;
  TcxLookupComboBoxProperties(cxvParametrosNOMCAM.Properties).ListSource := TInterfaceRelatorio(objRotinasGrid.objInteface).cdsCampos.dtsSource;

  cxvParametrosNOMCAM.Visible := objRotinasGrid.tpcGrupoChamada = tpcGrid;
end;

Class Procedure TfrmMapeiaParametrosEdicao.pCarregaParametrosBotao(objRotinasGrid: TRotinasGrid);
  Var
    frmMapeiaParametrosEdicao: TfrmMapeiaParametrosEdicao;
Begin
  Try
    Try
      objRotinasGrid.objMapeiaParametros.pFiltraParametros(objRotinasGrid.cdsRotinasRelatorio.FieldByName('ROT_NOMROT').AsString,
                                                           objRotinasGrid.cdsRotinasRelatorio.FieldByName('ROT_SEQREL').AsString, False);

      If objRotinasGrid.objMapeiaParametros.IsEmpty Then
      Begin
        If fEmptyStr(objRotinasGrid.cdsRotinasRelatorio.FieldByName('ROT_NOMROT').AsString) Then
          pMensagemOk('Esse relatório não possui parâmetros!')
        Else
          pMensagemOk('Essa rotina não possui parâmetros!');

        Exit;
      End;

      objRotinasGrid.objMapeiaParametros.pSalvaDados;

      pCriarFormularios(TfrmMapeiaParametrosEdicao, frmMapeiaParametrosEdicao);

      frmMapeiaParametrosEdicao.cxvParametrosNOMPAR.Visible := fEmptyStr(objRotinasGrid.cdsRotinasRelatorio.FieldByName('ROT_NOMROT').AsString);
      frmMapeiaParametrosEdicao.cxvParametrosEXIBIR.Visible := fEmptyStr(objRotinasGrid.cdsRotinasRelatorio.FieldByName('ROT_NOMROT').AsString);
      frmMapeiaParametrosEdicao.cxvParametrosEDITAV.Visible := fEmptyStr(objRotinasGrid.cdsRotinasRelatorio.FieldByName('ROT_NOMROT').AsString);

      If fEmptyStr(objRotinasGrid.cdsRotinasRelatorio.FieldByName('ROT_NOMROT').AsString) Then
        frmMapeiaParametrosEdicao.pnlRotina.Caption := 'Relatório ' + objRotinasGrid.cdsRotinasRelatorio.FieldByName('DESROT').AsString
      Else
        frmMapeiaParametrosEdicao.pnlRotina.Caption := 'Rotina ' + objRotinasGrid.cdsRotinasRelatorio.FieldByName('DESROT').AsString;

      frmMapeiaParametrosEdicao.objRotinasGrid := objRotinasGrid;

      If frmMapeiaParametrosEdicao.ShowModal <> mrOk Then
        objRotinasGrid.objMapeiaParametros.pRestauraDados;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmMapeiaParametrosEdicao.pCarregaParametrosBotao]');
      End;
    End;

    FreeAndNil(frmMapeiaParametrosEdicao)

  Finally
    objRotinasGrid.objMapeiaParametros.Filtered := False;
  End;
End;

end.
