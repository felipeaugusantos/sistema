unit untImportMargemLucroTabPrecoConfirma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, uni, untFuncoesSimples,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  untZClient, MyClassesUni, frxDBSet, Vcl.ComCtrls, cxContainer, cxProgressBar,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type

  TfrmImportMargemLucroTabPrecoConfirma = class(TfrmPaiConfirma)
    dtsDados: TDataSource;
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItensViewCodIte: TcxGridDBColumn;
    cxgItensViewDesIte: TcxGridDBColumn;
    cxgItensViewCodFab: TcxGridDBColumn;
    cxgItensViewMarT1A: TcxGridDBColumn;
    cxgItensViewMarT1N: TcxGridDBColumn;
    cxgItensViewMarT2A: TcxGridDBColumn;
    cxgItensViewMarT2N: TcxGridDBColumn;
    cxgItensViewMarT3A: TcxGridDBColumn;
    cxgItensViewMarT3N: TcxGridDBColumn;
    cxgItensViewMarT4A: TcxGridDBColumn;
    cxgItensViewMarT4N: TcxGridDBColumn;
    cxgItensViewMarT5A: TcxGridDBColumn;
    cxgItensViewMarT5N: TcxGridDBColumn;
    cxgItensViewMarT6A: TcxGridDBColumn;
    cxgItensViewMarT6N: TcxGridDBColumn;
    cxgItensViewMarT7A: TcxGridDBColumn;
    cxgItensViewMarT7N: TcxGridDBColumn;
    cxgItensViewTabPreA1: TcxGridDBColumn;
    cxgItensViewTabPreN1: TcxGridDBColumn;
    cxgItensViewTabPreA2: TcxGridDBColumn;
    cxgItensViewTabPreN2: TcxGridDBColumn;
    cxgItensViewTabPreA3: TcxGridDBColumn;
    cxgItensViewTabPreN3: TcxGridDBColumn;
    cxgItensViewTabPreA4: TcxGridDBColumn;
    cxgItensViewTabPreN4: TcxGridDBColumn;
    cxgItensViewTabPreA5: TcxGridDBColumn;
    cxgItensViewTabPreN5: TcxGridDBColumn;
    cxgItensViewTabPreA6: TcxGridDBColumn;
    cxgItensViewTabPreN6: TcxGridDBColumn;
    cxgItensViewTabPreA7: TcxGridDBColumn;
    cxgItensViewTabPreN7: TcxGridDBColumn;
    frxRelatorio: TfrxDBDataset;
    frxGen: TfrxUserDataSet;
    frxRepNaoImp: TfrxReport;
    btnVisProdNaoImp: TBitBtnLocked;
    frxRepNaoImp2: TfrxReport;
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnVisProdNaoImpClick(Sender: TObject);
    procedure frxGenGetValue(const VarName: string; var Value: Variant);
    procedure btnConfirmaClick(Sender: TObject);
    function fAlterarTabelas(pgbProgresso: TcxProgressBar): Boolean;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    cdsDadosAlt: TZClient;
    cdsRelatorio: TZClient;
    dtaDtaAltera: TDate;
    blnPorPreIte: Boolean;

//    function fCarregaEmpUtilizamPrecoMatriz: string;
    function fConfirmaData: Boolean;
    function  fProcessar(qryManipulada: TUniQuery): Boolean;
    procedure pMontarGrid;


  public
    { Public declarations }
    blnRecalcMargem: Boolean;
    function ShowModal(cdsDados: TZClient): integer; reintroduce;
    destructor Destroy; override;

 end;

var
 frmImportMargemLucroTabPrecoConfirma: TfrmImportMargemLucroTabPrecoConfirma;

implementation

{$R *.dfm}

uses untGravando, untPreAlt, untAltPrecoDigData, untAltEfetivacaoPrecos;
{ TfrmImportMargemLucroTabPrecoConfirma }

procedure TfrmImportMargemLucroTabPrecoConfirma.btnConfirmaClick(Sender: TObject);
begin
  If fConfirmaData then
  Begin
    Try
      Try
        pCriarFormularios(TfrmGravando, frmGravando);
        frmGravando.fExecutarAcao := fAlterarTabelas;
        frmGravando.lblGravando.Caption := 'Aguarde... Criando agendamento das alterações de preços.';
        frmGravando.ShowModal;
        pCriarFormularios(TfrmAltEfetivacaoPrecos, frmAltEfetivacaoPrecos);
        frmAltEfetivacaoPrecos.Showmodal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmImportTabPrecosItegerConfirma.pGravaLoteItens]');
        End;
      End;
    Finally
      FreeAndNil(frmGravando);
    End;
  End;
  inherited;
end;

procedure TfrmImportMargemLucroTabPrecoConfirma.btnVisProdNaoImpClick(Sender: TObject);
  Var
    frx: TfrxReport;
begin
  If blnRecalcMargem Then
    frx := frxRepNaoImp2
  Else
    frx := frxRepNaoImp;

  frx.Script.Variables['NOMREL'] := 'RELATÓRIO DE CRÍTICAS';

  If (Pos(fCfgSis('MARMKP'), '1_5_') = 0) And (Not blnRecalcMargem) Then
  begin
    TfrxMemoView(frx.FindObject('mmoMarg1')).Text := 'Mark.1';
    TfrxMemoView(frx.FindObject('mmoMarg2')).Text := 'Mark.2';
    TfrxMemoView(frx.FindObject('mmoMarg3')).Text := 'Mark.3';
    TfrxMemoView(frx.FindObject('mmoMarg4')).Text := 'Mark.4';
    TfrxMemoView(frx.FindObject('mmoMarg5')).Text := 'Mark.5';
    TfrxMemoView(frx.FindObject('mmoMarg6')).Text := 'Mark.6';
    TfrxMemoView(frx.FindObject('mmoMarg7')).Text := 'Mark.7';
  end;

  frx.DotMatrixReport           := False;
  frx.PrintOptions.PrintMode    := pmScale;
  frx.PrintOptions.PrintOnSheet := 9; //A4

  pPreviewReport(Self.Name, 'Relatório de críticas', frx);
end;

procedure TfrmImportMargemLucroTabPrecoConfirma.cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  If Pos('Nova', AViewInfo.Item.Caption) > 0 Then
    ACanvas.Brush.Color := clMoneyGreen
  Else If Pos('Atual', AViewInfo.Item.Caption) > 0 Then
    ACanvas.Brush.Color := clSilver;
end;

destructor TfrmImportMargemLucroTabPrecoConfirma.Destroy;
begin
  FreeAndNil(cdsRelatorio);
  inherited;
end;

function TfrmImportMargemLucroTabPrecoConfirma.fAlterarTabelas(pgbProgresso: TcxProgressBar): Boolean;
  var
    qryUpdate: TUniQuery;
begin
  Result := True;
  cdsDadosAlt.First;
  cdsDadosAlt.DisableControls;
  pgbProgresso.Properties.Max := cdsDadosAlt.RecordCount -1;
  qryUpdate := fCriaQuery;

  Try
    Try
      While not cdsDadosAlt.Eof Do
      Begin
        fStartTransaction;

        if fProcessar(qryUpdate) Then
           fCommit
        else
           fRollback;

        cdsDadosAlt.Next;
        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;
      End;
    Finally
      cdsDadosAlt.EnableControls;
    End;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

function TfrmImportMargemLucroTabPrecoConfirma.fConfirmaData: Boolean;
  var
    strMensagem: String;
Begin
  pCriarFormularios(TfrmAltPrecoDigData, frmAltPrecoDigData);
  frmAltPrecoDigData.ShowModal;
  Try
    If frmAltPrecoDigData.blnConfirma Then
    Begin
      If (frmAltPrecoDigData.dtaData = VS_Date) Then
        strMensagem := 'Os preços serão agendados para hoje. Confirma?'
      Else
        strMensagem := 'Os preços serão alterados no dia '+ DateToStr(frmAltPrecoDigData.dtaData) + '. Confirma?';
    End;
    Result := fMensagem('Confirmação' ,strMensagem, ['&Sim','&Não']) = 1;

    dtaDtaAltera := frmAltPrecoDigData.dtaData;
    blnPorPreIte := frmAltPrecoDigData.dtaData <> date;
  Finally
    FreeAndNil(frmAltPrecoDigData);
  End;
End;

function TfrmImportMargemLucroTabPrecoConfirma.fProcessar(
  qryManipulada: TUniQuery): Boolean;
begin
  Try
     Result := True;
     pIncluiPreIte(qryManipulada, cdsDadosAlt, dtaDtaAltera, 'TfrmImportTabPrecosItegerConfirma', fRetSequencial('PROPRI', VS_strCodEmp))
  Except
    On E:Exception do
    Begin
      pMensagensErro(E.Message,'[TfrmImportTabPrecosItegerConfirma.fProcessar.pIncluiPreIte]');
      Result := False;
    End;
  End;
end;

procedure TfrmImportMargemLucroTabPrecoConfirma.frxGenGetValue(const VarName: string; var Value: Variant);
begin

  If VarName = 'EMP_NOMEMP' Then
    Value := fCampoTabela('EMP_NOMEMP', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False)

  Else If VarName = 'EMP_NOMFAN' Then
    Value := fCampoTabela('EMP_NOMFAN', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False)

  Else If VarName = 'REL_NOMREL' Then
    Value := Self.Name

  Else If VarName = 'EMP_NOMCID' Then
    Value := fCampoTabela('CID_NOMCID', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False);

end;

procedure TfrmImportMargemLucroTabPrecoConfirma.pMontarGrid;
  var
    blnVisible: boolean;
    i: integer;
begin
  For i := 1 To 7 Do
  Begin
    blnVisible := VS_strTabPrc[i] = 'S';

    Case i of
     1: Begin
           cxgItensViewMarT1A.Visible := blnVisible;
           cxgItensViewMarT1N.Visible := blnVisible;
           cxgItensViewTabPreA1.Visible := blnVisible;
           cxgItensViewTabPreN1.Visible := blnVisible;
        End;
     2: Begin
           cxgItensViewMarT2A.Visible := blnVisible;
           cxgItensViewMarT2N.Visible := blnVisible;
           cxgItensViewTabPreA2.Visible := blnVisible;
           cxgItensViewTabPreN2.Visible := blnVisible;
        End;
     3: Begin
           cxgItensViewMarT3A.Visible := blnVisible;
           cxgItensViewMarT3N.Visible := blnVisible;
           cxgItensViewTabPreA3.Visible := blnVisible;
           cxgItensViewTabPreN3.Visible := blnVisible;
        End;
     4: Begin
           cxgItensViewMarT4A.Visible := blnVisible;
           cxgItensViewMarT4N.Visible := blnVisible;
           cxgItensViewTabPreA4.Visible := blnVisible;
           cxgItensViewTabPreN4.Visible := blnVisible;
        End;
     5: Begin
           cxgItensViewMarT5A.Visible := blnVisible;
           cxgItensViewMarT5N.Visible := blnVisible;
           cxgItensViewTabPreA5.Visible := blnVisible;
           cxgItensViewTabPreN5.Visible := blnVisible;
        End;
     6: Begin
           cxgItensViewMarT6A.Visible := blnVisible;
           cxgItensViewMarT6N.Visible := blnVisible;
           cxgItensViewTabPreA6.Visible := blnVisible;
           cxgItensViewTabPreN6.Visible := blnVisible;
        End;
     7: Begin
           cxgItensViewMarT7A.Visible := blnVisible;
           cxgItensViewMarT7N.Visible := blnVisible;
           cxgItensViewTabPreA7.Visible := blnVisible;
           cxgItensViewTabPreN7.Visible := blnVisible;
        End;
    End;
  End;









end;

function TfrmImportMargemLucroTabPrecoConfirma.ShowModal
  (cdsDados: TZClient): integer;
begin
  {****************************************************************************}
  {* 1 = Ocorreu tudo certo durante a Importação                               }
  {* 2 = A calculo para a tabela de preço excedeu 100% do valor do produto     }
  {* 0 = Não foi possivel localizar o produto informado no excel               }
  {****************************************************************************}
  cdsDadosAlt := cdsDados;
  cdsRelatorio := TZClient.Create(Self, '');
  Try
    cdsDadosAlt.Filter := 'IMPORT = 1';
    cdsDadosAlt.Filtered := True;
    cdsDadosAlt.Open;
    cdsRelatorio.Data := cdsDados.Data;
    cdsRelatorio.Filter := 'IMPORT <> 1 ';
    cdsRelatorio.Filtered := True;
    cdsRelatorio.Open;
    dtsDados.DataSet := cdsDadosAlt;
    frxRelatorio.DataSet := cdsRelatorio;
    btnVisProdNaoImp.Enabled := cdsRelatorio.RecordCount > 0;
    pnlInfo.Caption := 'Itens Processados com sucesso: ' + IntToStr(cdsDadosAlt.RecordCount);
    pnlInfo.Caption := pnlInfo.Caption + '    Itens Processados com Falha: ' + IntToStr(cdsRelatorio.RecordCount);
    pMontarGrid;
    Result := inherited ShowModal;
  Finally
    FreeAndNil(cdsRelatorio);
  End;
end;

procedure TfrmImportMargemLucroTabPrecoConfirma.FormShow(Sender: TObject);
begin
  inherited;
  If (Pos(fCfgSis('MARMKP'), '1_5_') = 0) Then
  Begin
    cxgItensViewMarT1A.Caption := '% Markup 1 (Atual)';
    cxgItensViewMarT1N.Caption := '% Markup 1 (Nova)';
    cxgItensViewMarT2A.Caption := '% Markup 2 (Atual)';
    cxgItensViewMarT2N.Caption := '% Markup 2 (Nova)';
    cxgItensViewMarT3A.Caption := '% Markup 3 (Atual)';
    cxgItensViewMarT3N.Caption := '% Markup 3 (Nova)';
    cxgItensViewMarT4A.Caption := '% Markup 4 (Atual)';
    cxgItensViewMarT4N.Caption := '% Markup 4 (Nova)';
    cxgItensViewMarT5A.Caption := '% Markup 5 (Atual)';
    cxgItensViewMarT5N.Caption := '% Markup 5 (Nova)';
    cxgItensViewMarT6A.Caption := '% Markup 6 (Atual)';
    cxgItensViewMarT6N.Caption := '% Markup 6 (Nova)';
    cxgItensViewMarT7A.Caption := '% Markup 7 (Atual)';
    cxgItensViewMarT7N.Caption := '% Markup 7 (Nova)';
  End;
end;

end.
