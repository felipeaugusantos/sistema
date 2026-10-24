unit untImportComisVendTabPrecoConfirma;

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
  cxDataControllerConditionalFormattingRulesManagerDialog, untPreAlt_Trigger;

type
  TfrmImportComisVendTabPrecoConfirma = class(TfrmPaiConfirma)
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
    cxgItensViewComTB1: TcxGridDBColumn;
    cxgItensViewComTBN1: TcxGridDBColumn;
    cxgItensViewComTA2: TcxGridDBColumn;
    cxgItensViewComTA3: TcxGridDBColumn;
    cxgItensViewComTA4: TcxGridDBColumn;
    cxgItensViewComTA5: TcxGridDBColumn;
    cxgItensViewComTA6: TcxGridDBColumn;
    cxgItensViewComTA7: TcxGridDBColumn;
    cxgItensViewComTN2: TcxGridDBColumn;
    cxgItensViewComTN3: TcxGridDBColumn;
    cxgItensViewComTN4: TcxGridDBColumn;
    cxgItensViewComTN5: TcxGridDBColumn;
    cxgItensViewComTN6: TcxGridDBColumn;
    cxgItensViewComTN7: TcxGridDBColumn;
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
    frxRepNaoImp: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    frxGen: TfrxUserDataSet;
    btnVisProdNaoImp: TBitBtnLocked;
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnVisProdNaoImpClick(Sender: TObject);
    procedure frxGenGetValue(const VarName: string; var Value: Variant);
    procedure btnConfirmaClick(Sender: TObject);
    function fAlterarTabelas(pgbProgresso: TcxProgressBar): Boolean;
  private
    { Private declarations }
    cdsDadosAlt: TZClient;
    cdsRelatorio: TZClient;
    strAgrupadorPreAlt: String;
    function fCarregaEmpUtilizamPrecoMatriz: string;
    procedure pMontaGrid;
  public
    { Public declarations }
    blnPrecoVenda: Boolean;
    function ShowModal(cdsDados: TZClient): integer; reintroduce;
    destructor Destroy; override;

 end;

var
 frmImportComisVendTabPrecoConfirma: TfrmImportComisVendTabPrecoConfirma;

implementation

{$R *.dfm}

uses untGravando, untPreAlt;
{ TfrmImportComisVendTabPrecoConfirma }

procedure TfrmImportComisVendTabPrecoConfirma.btnConfirmaClick(Sender: TObject);
begin
  If fPergunta('Este processo alterará as Tabelas de Preços dos produtos listados, deseja continuar?') Then
  Begin
    try
      Try
        pCriarFormularios(TfrmGravando, frmGravando);
        frmGravando.fExecutarAcao := fAlterarTabelas;
        frmGravando.lblGravando.Caption := 'Aguarde... Alterando valores das Tabelas de Preços.';
        frmGravando.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmImportComisVendTabPrecoConfirma.pGravaLoteItens]');
        End;
      End;
    Finally
      FreeAndNil(frmGravando);
    End;
  End;
  inherited;
end;

procedure TfrmImportComisVendTabPrecoConfirma.btnVisProdNaoImpClick(Sender: TObject);
begin
  frxRepNaoImp.Script.Variables['NOMREL'] := 'RELATÓRIO DE CRÍTICAS';

  TfrxMemoView(frxRepNaoImp.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');
  TfrxMemoView(frxRepNaoImp.FindObject('mmoZebra2')).Color := fCfgSis('CORZEB');

  frxRepNaoImp.DotMatrixReport           := False;
  frxRepNaoImp.PrintOptions.PrintMode    := pmScale;
  frxRepNaoImp.PrintOptions.PrintOnSheet := 9; //A4

  pPreviewReport(Self.Name, 'Relatório de críticas', frxRepNaoImp);
end;

procedure TfrmImportComisVendTabPrecoConfirma.cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  If Pos('Nova', AViewInfo.Item.Caption) > 0 Then
    ACanvas.Brush.Color := clMoneyGreen
  Else If Pos('Atual', AViewInfo.Item.Caption) > 0 Then
    ACanvas.Brush.Color := clSilver;
end;

destructor TfrmImportComisVendTabPrecoConfirma.Destroy;
begin
  FreeAndNil(cdsRelatorio);
  inherited;
end;

function TfrmImportComisVendTabPrecoConfirma.fAlterarTabelas(pgbProgresso: TcxProgressBar): Boolean;
  var
    qryUpdate: TUniQuery;

  function fUpdate: boolean;
  Begin
    Result := True;
    with qryUpdate do
    Begin
      ParamByName('PREALT').AsString:= strAgrupadorPreAlt;
      ParamByName('COMTB1').AsFloat := cdsDadosAlt.FieldByName('COMTBN1').AsFloat;
      ParamByName('COMTB2').AsFloat := cdsDadosAlt.FieldByName('COMTBN2').AsFloat;
      ParamByName('COMTB3').AsFloat := cdsDadosAlt.FieldByName('COMTBN3').AsFloat;
      ParamByName('COMTB4').AsFloat := cdsDadosAlt.FieldByName('COMTBN4').AsFloat;
      ParamByName('COMTB5').AsFloat := cdsDadosAlt.FieldByName('COMTBN5').AsFloat;
      ParamByName('COMTB6').AsFloat := cdsDadosAlt.FieldByName('COMTBN6').AsFloat;
      ParamByName('COMTB7').AsFloat := cdsDadosAlt.FieldByName('COMTBN7').AsFloat;
      ParamByName('MARBR1').AsFloat := cdsDadosAlt.FieldByName('MARBRN1').AsFloat;
      ParamByName('MARBR2').AsFloat := cdsDadosAlt.FieldByName('MARBRN2').AsFloat;
      ParamByName('MARBR3').AsFloat := cdsDadosAlt.FieldByName('MARBRN3').AsFloat;
      ParamByName('MARBR4').AsFloat := cdsDadosAlt.FieldByName('MARBRN4').AsFloat;
      ParamByName('MARBR5').AsFloat := cdsDadosAlt.FieldByName('MARBRN5').AsFloat;
      ParamByName('MARBR6').AsFloat := cdsDadosAlt.FieldByName('MARBRN6').AsFloat;
      ParamByName('MARBR7').AsFloat := cdsDadosAlt.FieldByName('MARBRN7').AsFloat;
      ParamByName('PREVE1').AsFloat := cdsDadosAlt.FieldByName('PREVEN1').AsFloat;
      ParamByName('PREVE2').AsFloat := cdsDadosAlt.FieldByName('PREVEN2').AsFloat;
      ParamByName('PREVE3').AsFloat := cdsDadosAlt.FieldByName('PREVEN3').AsFloat;
      ParamByName('PREVE4').AsFloat := cdsDadosAlt.FieldByName('PREVEN4').AsFloat;
      ParamByName('PREVE5').AsFloat := cdsDadosAlt.FieldByName('PREVEN5').AsFloat;
      ParamByName('PREVE6').AsFloat := cdsDadosAlt.FieldByName('PREVEN6').AsFloat;
      ParamByName('PREVE7').AsFloat := cdsDadosAlt.FieldByName('PREVEN7').AsFloat;
      ParamByName('CODITE').AsString := cdsDadosAlt.FieldByName('CODITE').AsString;
      try
         ExecSQL;
         If (Not VS_blnPreAltViaTrigger) Then
           Result := fGravaPreAlt(cdsDadosAlt.FieldByName('CODITE').AsString,
                                cdsDadosAlt.FieldByName('PRECUS').AsFloat,
                                cdsDadosAlt.FieldByName('PRECUS').AsFloat,
                                cdsDadosAlt.FieldByName('PREVE1').AsFloat,
                                cdsDadosAlt.FieldByName('PREVEN1').AsFloat,
                                cdsDadosAlt.FieldByName('MARBR1').AsFloat,
                                cdsDadosAlt.FieldByName('MARBRN1').AsFloat,
                                cdsDadosAlt.FieldByName('PREVE2' ).AsFloat,
                                cdsDadosAlt.FieldByName('PREVEN2').AsFloat,
                                cdsDadosAlt.FieldByName('MARBR2' ).AsFloat,
                                cdsDadosAlt.FieldByName('MARBRN2').AsFloat,
                                cdsDadosAlt.FieldByName('PREVE3' ).AsFloat,
                                cdsDadosAlt.FieldByName('PREVEN3').AsFloat,
                                cdsDadosAlt.FieldByName('MARBR3' ).AsFloat,
                                cdsDadosAlt.FieldByName('MARBRN3').AsFloat,
                                cdsDadosAlt.FieldByName('PREVE4' ).AsFloat,
                                cdsDadosAlt.FieldByName('PREVEN4').AsFloat,
                                cdsDadosAlt.FieldByName('MARBR4' ).AsFloat,
                                cdsDadosAlt.FieldByName('MARBRN4').AsFloat,
                                cdsDadosAlt.FieldByName('PREVE5' ).AsFloat,
                                cdsDadosAlt.FieldByName('PREVEN5').AsFloat,
                                cdsDadosAlt.FieldByName('MARBR5' ).AsFloat,
                                cdsDadosAlt.FieldByName('MARBRN5').AsFloat,
                                cdsDadosAlt.FieldByName('PREVE6' ).AsFloat,
                                cdsDadosAlt.FieldByName('PREVEN6').AsFloat,
                                cdsDadosAlt.FieldByName('MARBR6' ).AsFloat,
                                cdsDadosAlt.FieldByName('MARBRN6').AsFloat,
                                cdsDadosAlt.FieldByName('PREVE7' ).AsFloat,
                                cdsDadosAlt.FieldByName('PREVEN7').AsFloat,
                                cdsDadosAlt.FieldByName('MARBR7' ).AsFloat,
                                cdsDadosAlt.FieldByName('MARBRN7').AsFloat,

                                cdsDadosAlt.FieldByName('PRECOM').AsFloat,
                                cdsDadosAlt.FieldByName('PRECOM').AsFloat,

                                'IMPORTAÇÃO COMISSÃO VENDEDORES POR TABELA DE PREÇO',

                                Nil,
                                '',
                                strLoginUsuarioLogado);
      Except
        on E: Exception do
        Begin
          Result := False;
          pMensagensErro(E.Message,'[TfrmImportComisVendTabPrecoConfirma.fAlterarTabelas]');
        End;
      End;
    End;
  End;

begin

  Result := True;
  cdsDadosAlt.First;
  cdsDadosAlt.DisableControls;
  pgbProgresso.Properties.Max := cdsDadosAlt.RecordCount -1;
  qryUpdate := fCriaQuery();
  try
     qryUpdate.SQL.Add('UPDATE ITEGER SET');
     qryUpdate.Sql.Add('       ITE_PREALT = :PREALT,');
     qryUpdate.Sql.Add('       ITE_COMTB1 = :COMTB1,');
     qryUpdate.Sql.Add('       ITE_COMTB2 = :COMTB2,');
     qryUpdate.Sql.Add('       ITE_COMTB3 = :COMTB3,');
     qryUpdate.Sql.Add('       ITE_COMTB4 = :COMTB4,');
     qryUpdate.Sql.Add('       ITE_COMTB5 = :COMTB5,');
     qryUpdate.Sql.Add('       ITE_COMTB6 = :COMTB6,');
     qryUpdate.Sql.Add('       ITE_COMTB7 = :COMTB7,');
     qryUpdate.Sql.Add('       ITE_MARBR1 = :MARBR1,');
     qryUpdate.Sql.Add('       ITE_MARBR2 = :MARBR2,');
     qryUpdate.Sql.Add('       ITE_MARBR3 = :MARBR3,');
     qryUpdate.Sql.Add('       ITE_MARBR4 = :MARBR4,');
     qryUpdate.Sql.Add('       ITE_MARBR5 = :MARBR5,');
     qryUpdate.Sql.Add('       ITE_MARBR6 = :MARBR6,');
     qryUpdate.Sql.Add('       ITE_MARBR7 = :MARBR7,');
     qryUpdate.Sql.Add('       ITE_PREVE1 = :PREVE1,');
     qryUpdate.Sql.Add('       ITE_PREVE2 = :PREVE2,');
     qryUpdate.Sql.Add('       ITE_PREVE3 = :PREVE3,');
     qryUpdate.Sql.Add('       ITE_PREVE4 = :PREVE4,');
     qryUpdate.Sql.Add('       ITE_PREVE5 = :PREVE5,');
     qryUpdate.Sql.Add('       ITE_PREVE6 = :PREVE6,');
     qryUpdate.Sql.Add('       ITE_PREVE7 = :PREVE7 ');
     qryUpdate.Sql.Add(' WHERE ITE_CODITE = :CODITE ');
     qryUpdate.Sql.Add('   AND ITE_CODEMP IN ( '+ fCarregaEmpUtilizamPrecoMatriz + ' ) ');
     try
       strAgrupadorPreAlt := '';
       pPreAltDefineVariaveisAltPre(fNow, 'IMPORTAÇÃO COMISSÃO VENDEDORES POR TABELA DE PREÇO', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

       while not cdsDadosAlt.Eof do
       Begin
         fStartTransaction;
         If fUpdate then
           fCommit
         Else
           fRollback;

         cdsDadosAlt.Next;
         pgbProgresso.Position := pgbProgresso.Position + 1;
         Application.ProcessMessages;
       End;

     Finally
        strAgrupadorPreAlt := '';;

       cdsDadosAlt.EnableControls;
     End;
  finally
    FreeAndNil(qryUpdate);
  End;
end;

procedure TfrmImportComisVendTabPrecoConfirma.frxGenGetValue(const VarName: string; var Value: Variant);
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

procedure TfrmImportComisVendTabPrecoConfirma.pMontaGrid;
  Var
    i: integer;
    blnVisible: Boolean;
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
          cxgItensViewComTB1.Visible := blnVisible;
          cxgItensViewComTBN1.Visible := blnVisible;
        End;
     2: Begin
          cxgItensViewMarT2A.Visible := blnVisible;
          cxgItensViewMarT2N.Visible := blnVisible;
          cxgItensViewComTA2.Visible := blnVisible;
          cxgItensViewComTN2.Visible := blnVisible;
          cxgItensViewTabPreA2.Visible := blnVisible;
          cxgItensViewTabPreN2.Visible := blnVisible;
        End;
     3: Begin
          cxgItensViewMarT3A.Visible := blnVisible;
          cxgItensViewMarT3N.Visible := blnVisible;
          cxgItensViewComTA3.Visible := blnVisible;
          cxgItensViewComTN3.Visible := blnVisible;
          cxgItensViewTabPreA3.Visible := blnVisible;
          cxgItensViewTabPreN3.Visible := blnVisible;
        End;
     4: Begin
          cxgItensViewMarT4A.Visible := blnVisible;
          cxgItensViewMarT4N.Visible := blnVisible;
          cxgItensViewComTA4.Visible := blnVisible;
          cxgItensViewComTN4.Visible := blnVisible;
          cxgItensViewTabPreA4.Visible := blnVisible;
          cxgItensViewTabPreN4.Visible := blnVisible;
        End;
     5: Begin
          cxgItensViewMarT5A.Visible := blnVisible;
          cxgItensViewMarT5N.Visible := blnVisible;
          cxgItensViewComTA5.Visible := blnVisible;
          cxgItensViewComTN5.Visible := blnVisible;
          cxgItensViewTabPreA5.Visible := blnVisible;
          cxgItensViewTabPreN5.Visible := blnVisible;
        End;
     6: Begin
          cxgItensViewMarT6A.Visible := blnVisible;
          cxgItensViewMarT6N.Visible := blnVisible;
          cxgItensViewComTA6.Visible := blnVisible;
          cxgItensViewComTN6.Visible := blnVisible;
          cxgItensViewTabPreA6.Visible := blnVisible;
          cxgItensViewTabPreN6.Visible := blnVisible;
        End;
     7: Begin
          cxgItensViewMarT7A.Visible := blnVisible;
          cxgItensViewMarT7N.Visible := blnVisible;
          cxgItensViewComTA7.Visible := blnVisible;
          cxgItensViewComTN7.Visible := blnVisible;
          cxgItensViewTabPreA7.Visible := blnVisible;
          cxgItensViewTabPreN7.Visible := blnVisible;
        End;
    End;
  End;

  if (cxgItensViewMarT1N.Visible and cxgItensViewTabPreN1.Visible) Then
  Begin
    cxgItensViewMarT1N.Visible := Not blnPrecoVenda;
    cxgItensViewTabPreN1.Visible := blnPrecoVenda;
  End;

  if (cxgItensViewMarT2N.Visible and cxgItensViewTabPreN2.Visible) Then
  Begin
    cxgItensViewMarT2N.Visible := Not blnPrecoVenda;
    cxgItensViewTabPreN2.Visible := blnPrecoVenda;
  End;

  if (cxgItensViewMarT3N.Visible and cxgItensViewTabPreN3.Visible) Then
  Begin
    cxgItensViewMarT3N.Visible := Not  blnPrecoVenda;
    cxgItensViewTabPreN3.Visible := blnPrecoVenda;
  End;

  if (cxgItensViewMarT4N.Visible and cxgItensViewTabPreN4.Visible) Then
  Begin
    cxgItensViewMarT4N.Visible := Not blnPrecoVenda;
    cxgItensViewTabPreN4.Visible := blnPrecoVenda;
  End;

  if (cxgItensViewMarT5N.Visible and cxgItensViewTabPreN5.Visible) Then
  Begin
    cxgItensViewMarT5N.Visible := Not blnPrecoVenda;
    cxgItensViewTabPreN5.Visible := blnPrecoVenda;
  End;

  if (cxgItensViewMarT6N.Visible and cxgItensViewTabPreN6.Visible) Then
  Begin
    cxgItensViewMarT6N.Visible := Not blnPrecoVenda;
    cxgItensViewTabPreN6.Visible := blnPrecoVenda;
  End;

  if (cxgItensViewMarT7N.Visible and cxgItensViewTabPreN7.Visible) Then
  Begin
    cxgItensViewMarT7N.Visible := Not blnPrecoVenda;
    cxgItensViewTabPreN7.Visible := blnPrecoVenda;
  End;
end;

function TfrmImportComisVendTabPrecoConfirma.ShowModal
  (cdsDados: TZClient): integer;
begin
  {****************************************************************************}
  {* 1 = Ocorreu tudo certo durante a Importação                               }
  {* 2 = A calculo para a tabela de preço excedeu 100% do valor do produto     }
  {* 0 = Não foi possivel localizar o produto informado no excel               }
  {****************************************************************************}
  cdsDadosAlt := cdsDados;
  cdsRelatorio := TZClient.Create(Self, '');
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
  pMontaGrid;
  Result := inherited ShowModal;
end;

function TfrmImportComisVendTabPrecoConfirma.fCarregaEmpUtilizamPrecoMatriz: string;
Var
  qryEmpresa: TUniQuery;
  strSQL : String;

Begin
  Result := '("' + VS_strCodEmp + '")';
  qryEmpresa := fCriaQuery();
  try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_CODEMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_PREMAT = "S" ';

    (**********************************************************)
    (* SE UTILIZA DEFINIÇÃO DE QUEM É A MATRIZ                *)
    (* PEGA TODAS AS LOJAS QUE A EMPRESA CORRENTE COMO MATRIZ *)
    (*******************************************************LA*)
    If fCfgSis('INFMAT', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND EMP_CODMAT = ' + QuotedStr(VS_strCodEmp);
    End;

    With qryEmpresa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      If not qryEmpresa.IsEmpty then
      Begin
        Result := '';
        While not qryEmpresa.Eof do
        Begin
          Result := Result + '"' + qryEmpresa.FieldByName('EMP_CODEMP').AsString + '"';
          qryEmpresa.Next;
          if not qryEmpresa.Eof then
             Result := Result + ', '
          else
             Result := Result + ', "'  + VS_strCodEmp + '"'
        End;
      End;
    End;
  Finally
    FreeAndNil(qryEmpresa);
  End;
End;

end.
