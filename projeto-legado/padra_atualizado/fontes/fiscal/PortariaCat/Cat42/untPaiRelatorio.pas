unit untPaiRelatorio;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPai, Buttons, ExtCtrls, Printers, EditFocus,
  MaskEditFocus, QColorLabel, Menus, RLFilters, RLDraftFilter, RLReport,
  frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, frxADOComponents, Uni,
  frxDesgn, StrUtils, AppEvnts, BitBtnLockedIncrem, frxExportCSVTestabilidade;

type
  TfrmPaiRelatorio = class(TfrmPai) 
    btnImprimir: TBitBtnLocked;
    pnlDados: TPanel;
    gpbDestino: TGroupBox;
    edtDestino: TEditFocus;
    ColorLabel1: TColorLabel;
    frxExpRTF: TfrxRTFExport;
    frxExpXLS: TfrxXLSExport;
    frxExpHtml: TfrxHTMLExport;
    frxExpPDF: TfrxPDFExport;
    frxMatricial: TfrxDotMatrixExport;
    frxRelatorio: TfrxDBDataset;
    frxGen: TfrxUserDataSet;
    frxDesigner: TfrxDesigner;
    frxComandos: TfrxUserDataSet;
    btnConfigurar: TBitBtnLocked;
    shpMultSel: TShape;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure frxGenGetValue(const VarName: String; var Value: Variant);
    procedure frxComandosGetValue(const VarName: String;
      var Value: Variant);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  protected
    procedure pTabelaVazia;
  public
    { Public declarations }
    blnExcel  : Boolean;
    blnImprime: Boolean;
    strTipImp : String;
    intCount  : Integer;
    intGlobal : Integer;
    strFilRel : String;
  end;

Const
  MSG_IMPINVALIDA = 'Houve um erro ao enviar o relatório para a impressora.' + #13#10 +
                    'Verifique se a impressora selecionada é válida ou seu nome está digitado corretamente.';

var
  frmPaiRelatorio: TfrmPaiRelatorio;

implementation

uses
  untFuncoes;

{$R *.dfm}

{ TfrmPaiRelatorio }

procedure TfrmPaiRelatorio.pTabelaVazia;
begin
  fMensagem('AVISO', 'Não há dados para gerar o relatório!', ['OK']);
end;

procedure TfrmPaiRelatorio.FormShow(Sender: TObject);
begin
  inherited;
  {***************************************}
  {* POSICIONA O SHAPE Q IDENTIFICA SE O *}
  {* RELATÓRIO POSSUI CONSULTAS COM      *}
  {* MULTISELEÇÃO                        *}
  {***08/02/2008***********************ER*}
  shpMultSel.Left := pnlInfo.Width - shpMultSel.Width;
end;

procedure TfrmPaiRelatorio.btnImprimirClick(Sender: TObject);
begin
  inherited;

  Try
    btnImprimir.Enabled := False;
    blnImprime := fVerificaCampos;
  Finally
    btnImprimir.Enabled := True;
  End;

end;

procedure TfrmPaiRelatorio.FormActivate(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmPaiRelatorio.FormCreate(Sender: TObject);
begin
  inherited;

  intCount  := 0;
  intGlobal := 0;
  strFilRel := '';

  blnExcel  := False;
end;

procedure TfrmPaiRelatorio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
//
end;

procedure TfrmPaiRelatorio.edtDestinoExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtDestino.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
    edtDestino.SetFocus;
  End
  Else If Pos(edtDestino.Text, 'VI' + IIF(blnExcel, 'E', '')) <= 0 Then
  Begin
    edtDestino.SetFocus;
  End;

end;

procedure TfrmPaiRelatorio.frxGenGetValue(const VarName: String;
  var Value: Variant);
  Var
    qryCadEmp: TUniQuery;
begin
  inherited;


  Try
    qryCadEmp := fCriaQuery;

    With qryCadEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  EMP_NOMEMP NOMEMP, ');
      SQL.Add('  EMP_NOMFAN NOMFAN, ');
      SQL.Add('  CID_NOMCID NOMCID  ');
      SQL.Add('FROM ');
      SQL.Add('  CADEMP ');
      SQL.Add('  INNER JOIN CADCID ON EMP_CODCID = CID_CODCID ');
      SQL.Add('WHERE ');
      SQL.Add('  EMP_CODEMP = :CODEMP ');
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If VarName = 'EMP_NOMEMP' Then
        Value := FieldByName('NOMEMP').AsString

      Else If VarName = 'EMP_NOMFAN' Then
        Value := FieldByName('NOMFAN').AsString

      Else If VarName = 'REL_NOMREL' Then
        Value := Self.Name

      Else If VarName = 'EMP_NOMCID' Then
        Value := FieldByName('NOMCID').AsString;
        
      Close;
    End;

  Finally
    FreeAndNil(qryCadEmp);
  End;

end;

procedure TfrmPaiRelatorio.frxComandosGetValue(const VarName: String;
  var Value: Variant);
begin
  inherited;

  {****************************}
  {* ESPAÇAMENTO ENTRE LINHAS *}
  {*************************AF*}
  If VarName = 'UM_OITAVO_ON' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#270'

    Else
      Value := '';

  End

  Else If VarName = 'UM_OITAVO_OFF' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#272'

    Else
      Value := '';

  End

  {***********}
  {* NEGRITO *}
  {********AF*}
  Else If VarName = 'NEGRITO_ON' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#27#69'

    Else
      Value := '';

  End

  Else If VarName = 'NEGRITO_OFF' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#27#70'

    Else
      Value := '';

  End

  {*************}
  {* EXPANDIDO *}
  {**********AF*}
  Else If VarName = 'EXPANDIDO_ON' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#27#871'

    Else
      Value := '';

  End

  Else If VarName = 'EXPANDIDO_OFF' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#27#870'

    Else
      Value := '';

  End

  {*************}
  {* ITÁLICO   *}
  {**********AF*}
  Else If VarName = 'ITALICO_ON' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#274'

    Else
      Value := '';

  End

  Else If VarName = 'ITALICO_OFF' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#275'

    Else
      Value := '';

  End

  {*************************}
  {* CONDENSADO PARA 10CPI *}
  {**********************AF*}
  Else If VarName = 'COND_10CPI_ON' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#15#27#80'

    Else
      Value := '';

  End

  Else If VarName = 'COND_10CPI_OFF' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#18#27#80'

    Else
      Value := '';

  End

  {*************************}
  {* CONDENSADO PARA 12CPI *}
  {**********************AF*}
  Else If VarName = 'COND_12CPI_ON' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#15#27#77'

    Else
      Value := '';

  End

  Else If VarName = 'COND_12CPI_OFF' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#18#27#77'

    Else
      Value := '';

  End

  {**************************************}
  {* RESETA                             *}
  {***********************************AF*}
  Else If VarName = 'RESETA' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#27#64#18#27#80'

    Else
      Value := '';

  End;

end;

end.

