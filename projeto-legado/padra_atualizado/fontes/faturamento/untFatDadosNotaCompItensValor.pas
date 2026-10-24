unit untFatDadosNotaCompItensValor;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, untFuncFat, strUtils,
  ExtCtrls, EditFocus, Mask, MaskEditFocus, AppEvnts, Uni,untDigDescComplemento,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, DB, Windows, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, cxGridBandedTableView, cxGridDBBandedTableView,
  Datasnap.DBClient, UniClientDataSet, untFuncoes,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatDadosNotaCompItensValor = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlFundo: TPanel;
    cxgItensLevel: TcxGridLevel;
    cxgItens: TcxGridCitel;
    dtsItensNfe: TDataSource;
    cxgItensView: TcxGridDBBandedTableView;
    cdsItensNFe: TUniClientDataSet;
    cdsItensNFeAutoincremento: TStringField;
    cdsItensNFeCodigo: TStringField;
    cdsItensNFeDescricao: TStringField;
    cdsItensNFeUnidade: TStringField;
    cdsItensNFequantidade: TFloatField;
    cdsItensNFevalor_unitario: TFloatField;
    cdsItensNFedes_esp: TFloatField;
    cdsItensNFevalor_total: TFloatField;
    cdsItensNFevalor_unit_comp: TFloatField;
    cxgItensViewcodigo: TcxGridDBBandedColumn;
    cxgItensViewdescricao: TcxGridDBBandedColumn;
    cxgItensViewunidade: TcxGridDBBandedColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxsBands: TcxStyle;
    cxsIcms: TcxStyle;
    cxsIPI: TcxStyle;
    cxsRetido: TcxStyle;
    cdsItensNFeDocumento: TStringField;
    cxgItensViewdocumento: TcxGridDBBandedColumn;
    cxsGroupHeader: TcxStyle;
    cxgItensViewquantidade: TcxGridDBBandedColumn;
    cxgItensViewvalorunitario: TcxGridDBBandedColumn;
    cxgItensViewdescesp: TcxGridDBBandedColumn;
    cxgItensViewvalortotal: TcxGridDBBandedColumn;
    cxgItensViewvalorunitcomp: TcxGridDBBandedColumn;
    cxgItensViewvalortotalcomp: TcxGridDBBandedColumn;
    cdsItensNFevalor_total_comp: TFloatField;
    cdsItensNFeindex: TIntegerField;
    cdsItensNFeBASICM: TFloatField;
    cdsItensNFeALQICM: TFloatField;
    cdsItensNFeVALICM: TFloatField;
    cdsItensNFeBASIPI: TFloatField;
    cdsItensNFeALQIPI: TFloatField;
    cdsItensNFeVALIPI: TFloatField;
    cdsItensNFeBASRET: TFloatField;
    cdsItensNFeVALRET: TFloatField;
    cxgItensViewBasIcm: TcxGridDBBandedColumn;
    cxgItensViewAlqIcm: TcxGridDBBandedColumn;
    cxgItensViewValIcm: TcxGridDBBandedColumn;
    cxgItensViewBasIpi: TcxGridDBBandedColumn;
    cxgItensViewAlqIpi: TcxGridDBBandedColumn;
    cxgItensViewValIpi: TcxGridDBBandedColumn;
    cxgItensViewBasRet: TcxGridDBBandedColumn;
    cxgItensViewValRet: TcxGridDBBandedColumn;
    cdsItensNFeCLAFIS: TStringField;
    cdsItensNFeCODFIS: TStringField;
    cxgItensViewClaFis: TcxGridDBBandedColumn;
    cxgItensViewCodFis: TcxGridDBBandedColumn;
    cdsItensNFeALQINE: TFloatField;
    cdsItensNFeALQUFD: TFloatField;
    cdsItensNFeBCUFDE: TFloatField;
    cdsItensNFePERFCP: TFloatField;
    cdsItensNFePERPAR: TFloatField;
    cdsItensNFeVALDES: TFloatField;
    cdsItensNFeVALFCP: TFloatField;
    cdsItensNFeVALORI: TFloatField;
    cdsItensNFeBASFCP: TFloatField;
    cdsItensNFeGRVINF: TBooleanField;
    cdsItensNFeBFCPST: TFloatField;
    cdsItensNFeVFCPST: TFloatField;
    cxgItensViewBFCPST: TcxGridDBBandedColumn;
    cxgItensViewVFCPST: TcxGridDBBandedColumn;
    cdsItensNFePFCPST: TFloatField;
    procedure btnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure cdsItensNFeBeforePost(DataSet: TDataSet);
    procedure cxgItensViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cdsItensNFeAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    blnValidar : Boolean;

    procedure pCarregarItens;
    procedure pCarregaDadosItem(qryItens: TUniQuery; strCodIte: String);
    procedure pSalvarValoresDigitados;
    function fValidaImpostosDigitados: Boolean;
  public
    { Public declarations }
    fatVenda: TFatVenda;
  end;

var
  frmFatDadosNotaCompItensValor: TfrmFatDadosNotaCompItensValor;

implementation

uses untfuncoesSimples,untConsultas, untTypesSistema,untFuncFatTypes, untNotCom,
  untConstantes, untFuncoesConsulta, untCalculoPisCofins, Shared.Functions.Types;

{$R *.dfm}

procedure TfrmFatDadosNotaCompItensValor.btnCancelaClick(Sender: TObject);
begin
  inherited;

  If fPergunta('Deseja realmente cancelar a operação?') Then
    Close;
end;

procedure TfrmFatDadosNotaCompItensValor.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If fValidaImpostosDigitados Then
  Begin
    pSalvarValoresDigitados;
    Close;
  End;
end;

procedure TfrmFatDadosNotaCompItensValor.cdsItensNFeAfterPost(DataSet: TDataSet);
var
  intRecNo : Integer;
begin
  inherited;

  intRecNo                 := DataSet.RecNo;
  Try
    DataSet.DisableControls;

    DataSet.Filter           := 'valor_unit_comp > 0';
    DataSet.Filtered         := True;
    btnConfirmaDados.Enabled := Not Dataset.IsEmpty;
  Finally
    DataSet.Filtered := False;
    DataSet.Filter   := '';
    DataSet.RecNo    := intRecNo;

    DataSet.EnableControls;
  End;
end;

procedure TfrmFatDadosNotaCompItensValor.cdsItensNFeBeforePost(DataSet: TDataSet);
var intContador: integer;

  function fValidaValor(fldValor: TField): Boolean;
  begin
    Result := fldValor.AsFloat >= 0;

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'O Campo ' + fldValor.DisplayLabel +
                ' deve ser maior ou igual a zero!', ['&Ok']);
    End;
  end;

  procedure pCalculaValor(fldUni, fldQtd, fldValor: TField);
  begin
    If DataSet.State = dsEdit Then
    Begin
      fldValor.AsFloat := fFormataFloat(fldUni.AsFloat * fldQtd.AsFloat, 2);
    End;
  end;

begin
  inherited;

  If Not blnValidar Then
    Exit;

  pCalculaValor(cdsItensNFeValor_unit_comp, cdsItensNFeQuantidade, cdsItensNFeValor_total_comp);

  If (Not fValidaValor(cdsItensNFeValor_unit_comp)) Then
  Begin
    DataSet.Cancel;
    Abort;
  End
  Else
  Begin
    For intContador := 0 To Length(fatVenda.arrMatItens) -1 Do
    Begin
      If fatVenda.arrMatItens[intContador].strRefere = cdsItensNFeAutoincremento.AsString Then
      Begin
        fatVenda.arrMatItens[intContador].fltUniTar := cdsItensNFeValor_unit_comp.AsFloat;
        fatVenda.arrMatItens[intContador].fltUniOri := cdsItensNFeValor_unit_comp.AsFloat;
        fatVenda.arrMatItens[intContador].fltUniVis := cdsItensNFeValor_unit_comp.AsFloat;
        fatVenda.arrMatItens[intContador].fltUniTmp := cdsItensNFeValor_unit_comp.AsFloat;
        fatVenda.arrMatItens[intContador].fltTotIte := cdsItensNFeValor_total_comp.AsFloat;
        Break;
      End;
    End;

    fatvenda.pCalculaTotGer;

    cdsItensNFeCLAFIS.AsString := fatVenda.arrMatItens[intContador].strClaFis;
    cdsItensNFeCODFIS.AsString := fatVenda.arrMatItens[intContador].strCodFis;
    cdsItensNFeBASICM.AsFloat  := fatVenda.arrMatItens[intContador].fltBasIcm;
    cdsItensNFeALQICM.AsFloat  := fatVenda.arrMatItens[intContador].fltAlqIcm;
    cdsItensNFeVALICM.AsFloat  := fatVenda.arrMatItens[intContador].fltValIcm;
    cdsItensNFeBASIPI.AsFloat  := fatVenda.arrMatItens[intContador].fltBasIpi;
    cdsItensNFeALQIPI.AsFloat  := fatVenda.arrMatItens[intContador].fltAlqIpi;
    cdsItensNFeVALIPI.AsFloat  := fatVenda.arrMatItens[intContador].fltValIpi;
    cdsItensNFeBASRET.AsFloat  := fatVenda.arrMatItens[intContador].fltBasRet;
    cdsItensNFeVALRET.AsFloat  := fatVenda.arrMatItens[intContador].fltValRet;

    cdsItensNFeALQINE.AsFloat  := fatVenda.arrMatItens[intContador].recDifalFCP.fltAlqIne;
    cdsItensNFeALQUFD.AsFloat  := fatVenda.arrMatItens[intContador].recDifalFCP.fltAlqUfd;
    cdsItensNFeBCUFDE.AsFloat  := fatVenda.arrMatItens[intContador].recDifalFCP.fltBcuFde;
    cdsItensNFePERPAR.AsFloat  := fatVenda.arrMatItens[intContador].recDifalFCP.fltPerPar;
    cdsItensNFeVALDES.AsFloat  := fatVenda.arrMatItens[intContador].recDifalFCP.fltDifDes;
    cdsItensNFeVALORI.AsFloat  := fatVenda.arrMatItens[intContador].recDifalFCP.fltDifOri;
    cdsItensNFeVALFCP.AsFloat  := fatVenda.arrMatItens[intContador].recDifalFCP.fltValFcp;
    cdsItensNFePERFCP.AsFloat  := fatVenda.arrMatItens[intContador].recDifalFCP.fltPerFcp;
    cdsItensNFeBASFCP.AsFloat  := fatVenda.arrMatItens[intContador].recDifalFCP.fltBasFcp;
    cdsItensNFeGRVINF.AsBoolean:= fatVenda.arrMatItens[intContador].recDifalFCP.blnGrvInf;

    If cdsItensNFeVALRET.AsFloat > 0 Then
    Begin
      cdsItensNFeBFCPST.AsFloat := fatVenda.arrMatItens[intContador].recDifalFCP.fltBasFcp;
      cdsItensNFePFCPST.AsFloat := fatVenda.arrMatItens[intContador].recDifalFCP.fltPerFcp;
      cdsItensNFeVFCPST.AsFloat := fatVenda.arrMatItens[intContador].recDifalFCP.fltValFcp;
    End
    Else
    Begin
      cdsItensNFeBFCPST.AsFloat := 0;
      cdsItensNFePFCPST.AsFloat := 0;
      cdsItensNFeVFCPST.AsFloat := 0;
    End;
  End;

end;

procedure TfrmFatDadosNotaCompItensValor.cxgItensViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  function GetFocusedColumnIndex: Integer;
    Var
      intIndex: Integer;
  begin
    Result := -1;
    For intIndex := 0 To cxgItensView.ColumnCount - 1 Do
      If cxgItensView.Columns[intIndex].Focused Then
      Begin
        Result := intIndex;
        Break;
      End;
  end;

  function GetLastFocusingColumnIndex: Integer;
    Var
      intIndex: Integer;
  begin
    Result := -1;
    For intIndex := 0 To cxgItensView.ColumnCount - 1 Do
      With cxgItensView.Columns[intIndex], Options Do
        If Visible And Focusing Then
          Result := intIndex;
  end;

  function GetFirstFocusingColumnIndex: Integer;
    Var
      intIndex: Integer;
  begin
    Result := -1;
    For intIndex := 0 To cxgItensView.ColumnCount - 1 Do
      With cxgItensView.Columns[intIndex], Options Do
        If Visible And Focusing Then
        Begin
          Result := intIndex;
          Break;
        End;
  end;

  procedure GoToNextCell;
    Var
      FocusIndex: Integer;
  begin
    FocusIndex := GetFocusedColumnIndex;

    If FocusIndex = GetLastFocusingColumnIndex Then
    Begin

      If cxgItensView.DataController.RecNo < cxgItensView.DataController.RecordCount Then
      Begin
        cxgItensView.DataController.GotoNext;
        cxgItensView.DataController.Edit;
        cxgItensView.Columns[GetFirstFocusingColumnIndex].Focused := True;
      End
      Else
        SelectNext(ActiveControl, True, True);

      Exit;
    End;

    Repeat
      Inc(FocusIndex);

      With cxgItensView.Columns[FocusIndex], Options Do
      Begin
        If Visible And Focusing Then
        Begin
          Focused := True;
          Break;
        End;
      End;

    Until FocusIndex = GetLastFocusingColumnIndex;

  end;

begin
  inherited;
  Case Key Of
    VK_ESCAPE : btnCancelaDados.Click;

    VK_F10    : Begin
                  btnConfirmaDados.Click;
                  Key := 0;
                End;

    VK_RETURN : If cxgitensview.Focused Then
                Begin
                  If (cdsItensNfe.State = dsEdit) Then
                    cdsItensNfe.Post;

                  GoToNextCell;
                End;
  End;
end;

procedure TfrmFatDadosNotaCompItensValor.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(cdsItensNFeCodigo);
end;

procedure TfrmFatDadosNotaCompItensValor.FormShow(Sender: TObject);
begin
  inherited;

  btnConfirmaDados.Enabled := False;
  pCarregarItens;
end;

function TfrmFatDadosNotaCompItensValor.fValidaImpostosDigitados: Boolean;
begin

  Try
    cdsItensNFe.First;

    While Not cdsItensNFe.Eof Do
    Begin
      If cdsItensNFe.State = dsBrowse Then
        cdsItensNFe.Edit;

      cdsItensNFe.Post;
      cdsItensNFe.Next;
    End;

    Result := True;

  Except
    On E: EAbort Do
    Begin
      Result := False;
      //Caso abortou a operacao nao deve exibir a mensagem de erro
    End;

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

end;

procedure TfrmFatDadosNotaCompItensValor.pCarregaDadosItem(qryItens: TUniQuery;
  strCodIte: String);
begin
  qryItens.SQL.Clear;
  qryItens.SQL.Add('SELECT ');
  qryItens.SQL.Add('  I.ITE_CODITE, ');
  qryItens.SQL.Add('  I.ITE_CODGRU, ');
  qryItens.SQL.Add('  I.ITE_DESITE, ');
  qryItens.SQL.Add('  I.ITE_CODUNI, ');
  qryItens.SQL.Add('  I.ITE_CODMAR, ');
  qryItens.SQL.Add('  I.ITE_CODFOR, ');
  qryItens.SQL.Add('  I.ITE_INCPIS, ');
  qryItens.SQL.Add('  I.ITE_CLAIPI, ');
  qryItens.SQL.Add('  I.ITE_EXCIPI, ');

  If fCfgSis('TIPABF', varString) = '1' Then
    qryItens.SQL.Add('  I.ITE_CODABF AS ITE_CODABF, ')
  Else
    qryItens.SQL.Add('  G.ITE_CODABF AS ITE_CODABF, ');

  qryItens.SQL.Add('  G.ITE_IPISAI ');
  qryItens.SQL.Add('FROM ');
  qryItens.SQL.Add('  CADITE I ');
  qryItens.SQL.Add('INNER JOIN ITEGER G ');
  qryItens.SQL.Add('  ON G.ITE_CODITE = I.ITE_CODITE ');
  qryItens.SQL.Add('WHERE ');
  qryItens.SQL.Add('  I.ITE_CODITE = :CODITE AND ');
  qryItens.SQL.Add('  G.ITE_CODEMP = :CODEMP ');

  qryItens.ParamByName('CODITE').AsString := strCodIte;
  qryItens.ParamByName('CODEMP').AsString := fatVenda.objNfeComplemento.notaReferenciada.strCodEmp;
  qryItens.Open;
end;

procedure TfrmFatDadosNotaCompItensValor.pCarregarItens;
  Var
    itemNFe: TNfeComplementoItem;
    intContador: Integer;
    index: Integer;
    qryDadosItens: TUniQuery;
    forTin: TForTin;
    dadosMadeira: TDadosMadeira;
begin
  blnValidar := False;
  index      := 0;
  qryDadosItens := fCriaQuery(Nil);

  cdsItensNFe.CreateDataset;
  cdsItensNFe.IndexFieldNames := 'index';

  FillChar(forTin, SizeOf(TForTin), #0);
  FillChar(dadosMadeira, SizeOf(TDadosMadeira), #0);

  SetLength(fatVenda.arrMatItens, 0);
  cdsVenda.EmptyDataSet;

  For itemNFe In fatVenda.objNfeComplemento.arrItensNFe Do
  Begin
    pCarregaDadosItem(qryDadosItens, itemNFe.strCodIte);

    fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
            Nil, 'NOR',
            qryDadosItens.FieldByName('ITE_CODGRU').AsString,
            itemNFe.strCodIte,
            qryDadosItens.FieldByName('ITE_DESITE').AsString,
            qryDadosItens.FieldByName('ITE_DESITE').AsString,
            '',
            qryDadosItens.FieldByName('ITE_CODUNI').AsString,
            qryDadosItens.FieldByName('ITE_CODUNI').AsString,
            qryDadosItens.FieldByName('ITE_CODMAR').AsString,
            qryDadosItens.FieldByName('ITE_CODFOR').AsString,
            itemNFe.strAutInc,
            itemNFe.fltValUni,
            itemNFe.fltValUni,
            itemNFe.fltValUni,
            itemNFe.fltValUni,
            0,
            itemNFe.fltQtdIte,
            itemNFe.fltTotIte,
            IIF(StrToIntDef(LeftStr(itemNFe.strClaFis, 1), 5) < 5, 'E', 'S'),
            itemNFe.fltTotIte,
            itemNFe.fltTotIte,
            'N',
            qryDadosItens.FieldByName('ITE_IPISAI').AsFloat,
            0,
            itemNFe.fltValUni,
            itemNFe.fltValUni,
            itemNFe.fltValUni,
            itemNFe.fltValUni,
            itemNFe.fltValUni,
            itemNFe.fltValUni,
            itemNFe.fltValUni,
            0,
            0,
            qryDadosItens.FieldByName('ITE_INCPIS').AsString,
            0,
            0,
            0,
            '',
            '',
            '',
            0,
            0,
            '',
            0,
            0,
            0,
            0,
            qryDadosItens.FieldByName('ITE_CLAIPI').AsString,
            '',
            '',
            '',
            '',
            0,
            '',
            0,
            0,
            0,
            0,
            0,
            '',
            '',
            0,
            0,
            qryDadosItens.FieldByName('ITE_CODABF').AsString,
            0,
            0,
            'N',
            0,
            0,
            0,
            0,
            '',
            0,
            '',
            0,
            0,
            '',
            '',
            '',
            0,
            0,
            0,
            '',
            '',
            0,
            0,
            '',
            '',
            '',
            0,
            '',
            '',
            '',
            0,
            0,
            0,
            '',
            '',
            'N',
            '',
            '',
            itemNFe.strSigUni,
            0,
            0,
            '',
            '',
            '',
            False,
            '',
            '',
            '',
            0,
            0,
            0,
            0,
            0,
            0,
            '',
            '',
            '',
            '1',
            0,
            0,
            '',
            0,
            '',
            0,
            '',
            '',
            'N',
            '',
            0,
            0,
            itemNFe.fltDesEsp,
            0,
            'N',
            '',
            itemNFe.fltValUni,
            itemNFe.fltValUni,
            0,
            0,
            0,
            0,
            0,
            0,
            forTin,
            '',
            '',
            '',
            '',
            '',
            False,
            '',
            '',
            0,
            '',
            '',
            '',
            0,
            0,
            0,
            '',
            0,
            False,
            '',
            '',
            '',
            0,
            0,
            '',
            '',
            dadosMadeira,
            0,
            0,
            0,
            '',
            0,
            '',
            '',
            0,
            0,
            '',
            '',
            0,
            '',
            'N',
            0,
            0,
            0,
            False,
            False,
            'N',
            '',
            0,
            0,
            '',
            'N',
            0,
            '',
            '',
            '',
            '',
            qryDadosItens.FieldByName('ITE_EXCIPI').AsString,
            0,
            '',
            itemNFe.strClaFis);

    cdsItensNFe.Append;
    cdsItensNFeIndex.AsInteger          := index;
    cdsItensNFeDocumento.AsString       := fatVenda.objNfeComplemento.notaReferenciada.strNumDoc + '-' +
                                           fatVenda.objNfeComplemento.notaReferenciada.strEspDoc + '-' +
                                           fatVenda.objNfeComplemento.notaReferenciada.strCodEmp;
    cdsItensNFeAutoincremento.AsString  := itemNFe.strAutInc;
    cdsItensNFeCodigo.AsString          := itemNFe.strCodIte;
    cdsItensNFeDescricao.AsString       := itemNFe.strDesIte;
    cdsItensNFeUnidade.AsString         := itemNFe.strSigUni;
    cdsItensNFeQuantidade.AsFloat       := itemNFe.fltQtdIte;
    cdsItensNFeValor_unitario.AsFloat   := itemNFe.fltValUni;
    cdsItensNFeDes_esp.AsFloat          := itemNFe.fltDesEsp;
    cdsItensNFeValor_total.AsFloat      := itemNFe.fltTotIte;
    cdsItensNFeValor_total_comp.AsFloat := itemNFe.fltValCom;

    If (itemNFe.fltValCom > 0) Then
      cdsItensNFeValor_unit_comp.AsFloat := (itemNFe.fltValCom / itemNFe.fltQtdIte)
    Else
      cdsItensNFeValor_unit_comp.AsFloat := 0;

    cdsItensNFe.Post;
    Inc(index);
  End;

  fatvenda.blnNotaCompValor := True;
  fatVenda.pPreencheMatrizFechamento;
  fatvenda.blnNotaCompValor := False;

  //Atualiza unitário e totite para calcular os impostos em cima do valor de complemento
  For itemNFe In fatVenda.objNfeComplemento.arrItensNFe Do
  Begin
    If (itemNFe.fltValCom > 0) Then
    Begin
      For intContador := 0 To Length(fatVenda.arrMatItens) -1 Do
      Begin
        If fatVenda.arrMatItens[intContador].strRefere = itemNFe.strAutInc Then
        Begin
          fatVenda.arrMatItens[intContador].fltUniTar := itemNFe.fltValCom / itemNFe.fltQtdIte;
          fatVenda.arrMatItens[intContador].fltUniOri := itemNFe.fltValCom / itemNFe.fltQtdIte;
          fatVenda.arrMatItens[intContador].fltUniVis := itemNFe.fltValCom / itemNFe.fltQtdIte;
          fatVenda.arrMatItens[intContador].fltUniTmp := itemNFe.fltValCom / itemNFe.fltQtdIte;
          fatVenda.arrMatItens[intContador].fltTotIte := itemNFe.fltValCom;
        End;
      End;
    End;
  End;

  fatvenda.pCalculaTotGer;

  For intContador := 0 To Length(fatVenda.arrMatItens) -1 Do
  Begin
    If cdsItensNFe.Locate('autoincremento', fatVenda.arrMatItens[intContador].strRefere, []) Then
    Begin
      cdsItensNFe.Edit;
      cdsItensNFeCLAFIS.AsString := fatVenda.arrMatItens[intContador].strClaFis;
      cdsItensNFeCODFIS.AsString := fatVenda.arrMatItens[intContador].strCodFis;
      cdsItensNFeBASICM.AsFloat  := fatVenda.arrMatItens[intContador].fltBasIcm;
      cdsItensNFeALQICM.AsFloat  := fatVenda.arrMatItens[intContador].fltAlqIcm;
      cdsItensNFeVALICM.AsFloat  := fatVenda.arrMatItens[intContador].fltValIcm;
      cdsItensNFeBASIPI.AsFloat  := fatVenda.arrMatItens[intContador].fltBasIpi;
      cdsItensNFeALQIPI.AsFloat  := fatVenda.arrMatItens[intContador].fltAlqIpi;
      cdsItensNFeVALIPI.AsFloat  := fatVenda.arrMatItens[intContador].fltValIpi;
      cdsItensNFeBASRET.AsFloat  := fatVenda.arrMatItens[intContador].fltBasRet;
      cdsItensNFeVALRET.AsFloat  := fatVenda.arrMatItens[intContador].fltValRet;

      cdsItensNFeALQINE.AsFloat  := fatVenda.arrMatItens[intContador].recDifalFCP.fltAlqIne;
      cdsItensNFeALQUFD.AsFloat  := fatVenda.arrMatItens[intContador].recDifalFCP.fltAlqUfd;
      cdsItensNFeBCUFDE.AsFloat  := fatVenda.arrMatItens[intContador].recDifalFCP.fltBcuFde;
      cdsItensNFePERPAR.AsFloat  := fatVenda.arrMatItens[intContador].recDifalFCP.fltPerPar;
      cdsItensNFeVALDES.AsFloat  := fatVenda.arrMatItens[intContador].recDifalFCP.fltDifDes;
      cdsItensNFeVALORI.AsFloat  := fatVenda.arrMatItens[intContador].recDifalFCP.fltDifOri;
      cdsItensNFeVALFCP.AsFloat  := fatVenda.arrMatItens[intContador].recDifalFCP.fltValFcp;
      cdsItensNFePERFCP.AsFloat  := fatVenda.arrMatItens[intContador].recDifalFCP.fltPerFcp;
      cdsItensNFeBASFCP.AsFloat  := fatVenda.arrMatItens[intContador].recDifalFCP.fltBasFcp;
      cdsItensNFeGRVINF.AsBoolean:= fatVenda.arrMatItens[intContador].recDifalFCP.blnGrvInf;

      If cdsItensNFeVALRET.AsFloat > 0 Then
      Begin
        cdsItensNFeBFCPST.AsFloat := fatVenda.arrMatItens[intContador].recDifalFCP.fltBasFcp;
        cdsItensNFePFCPST.AsFloat := fatVenda.arrMatItens[intContador].recDifalFCP.fltPerFcp;
        cdsItensNFeVFCPST.AsFloat := fatVenda.arrMatItens[intContador].recDifalFCP.fltValFcp;
      End
      Else
      Begin
        cdsItensNFeBFCPST.AsFloat := 0;
        cdsItensNFePFCPST.AsFloat := 0;
        cdsItensNFeVFCPST.AsFloat := 0;
      End;

      cdsItensNFe.Post;
    End;
  End;

  pSetFocus(cxgItens);
  cxgItensView.DataController.GoToFirst;//Posiciona na primeira linha (Agrupamento documento)
  cxgItensView.DataController.GoToNext;//Posiciona na segunda linha (Primeiro registro)

  cxgItensView.DataController.Edit;

  blnValidar := True;
end;

procedure TfrmFatDadosNotaCompItensValor.pSalvarValoresDigitados;
  Var
    intItem : Integer;
    itemNFe : TNfeComplementoItem;
    objCalcPisCof : TCalculoPisCofins;
    recCalcResult : TResultPisCofins;
begin
  objCalcPisCof := TCalculoPisCofins.Create;
  Try
    For intItem := 0 To Length(fatVenda.objNfeComplemento.arrItensNFe) -1 Do
    Begin
      itemNfe := fatVenda.objNfeComplemento.arrItensNFe[intItem];

      If cdsItensNFe.Locate('autoincremento', itemNFe.strAutInc, []) Then
      Begin
        itemNFe.tncTipoItemNotaComplemento := tncComplementoValor;

        itemNFe.fltValCom := cdsItensNFeValor_total_comp.AsFloat;
        itemNFe.fltUnitar := cdsItensNFeValor_unit_comp.AsFloat;

        FillChar(recCalcResult, SizeOf(recCalcResult), #0);

        recCalcResult := objCalcPisCof.fCalculoPisCofins(VS_strCodEmp,
                                                         itemNFe.strCodIte,
                                                         itemNFe.strClaFis,
                                                         itemNFe.strCstOri,
                                                         fatVenda.strCodCli,
                                                         fatVenda.VS_strSimPau,
                                                         'NC',
                                                         itemNFe.fltValCom,
                                                         0,
                                                         0,
                                                         0,
                                                         0,
                                                         0,
                                                         0,
                                                         0,
                                                         IIF(fatVenda.fDocumentoParaFornecedor, 'F', 'C'),
                                                         itemNFe.strIncPis,
                                                         fatVenda.strSitP_C,
                                                         fatVenda.strMenP_C,
                                                         itemNFe.dtaDtaEnt,
                                                         '',
                                                         False,
                                                         False,
                                                         '',
                                                         '',
                                                         '',
                                                         itemNFe.strClaIpi);

        itemNFe.strCstPis := recCalcResult.strCstPis;
        itemNFe.fltBasPis := recCalcResult.dblBasePis;
        itemNFe.fltValPis := recCalcResult.dblValorPis;
        itemNFe.fltAlqPis := recCalcResult.dblAlqPis;

        itemNFe.strCstCof := recCalcResult.strCstCof;
        itemNFe.fltBasCof := recCalcResult.dblBaseCof;
        itemNFe.fltValCof := recCalcResult.dblValorCof;
        itemNFe.fltAlqCof := recCalcResult.dblAlqCof;

        itemNFe.strClaFis := cdsItensNFeCLAFIS.AsString;
        itemNFe.strCodFis := cdsItensNFeCODFIS.AsString;
        itemNFe.fltBasIcm := cdsItensNFeBASICM.AsFloat;
        itemNFe.fltAlqIcm := cdsItensNFeALQICM.AsFloat;
        itemNFe.fltValIcm := cdsItensNFeVALICM.AsFloat;
        itemNFe.fltBasIpi := cdsItensNFeBASIPI.AsFloat;
        itemNFe.fltAlqIpi := cdsItensNFeALQIPI.AsFloat;
        itemNFe.fltValIpi := cdsItensNFeVALIPI.AsFloat;
        itemNFe.fltBasRet := cdsItensNFeBASRET.AsFloat;
        itemNFe.fltValRet := cdsItensNFeVALRET.AsFloat;

        itemNFe.recDifalFCP.fltAlqIne := cdsItensNFeALQINE.AsFloat;
        itemNFe.recDifalFCP.fltAlqUfd := cdsItensNFeALQUFD.AsFloat;
        itemNFe.recDifalFCP.fltBcuFde := cdsItensNFeBCUFDE.AsFloat;
        itemNFe.recDifalFCP.fltPerPar := cdsItensNFePERPAR.AsFloat;
        itemNFe.recDifalFCP.fltDifDes := cdsItensNFeVALDES.AsFloat;
        itemNFe.recDifalFCP.fltDifOri := cdsItensNFeVALORI.AsFloat;
        itemNFe.recDifalFCP.fltValFcp := cdsItensNFeVALFCP.AsFloat;
        itemNFe.recDifalFCP.fltPerFcp := cdsItensNFePERFCP.AsFloat;
        itemNFe.recDifalFCP.fltBasFcp := cdsItensNFeBASFCP.AsFloat;
        itemNFe.recDifalFCP.blnGrvInf := cdsItensNFeGRVINF.AsBoolean;

        If cdsItensNFeVFCPST.AsFloat > 0 Then
        Begin
          itemNFe.fltBasFcpST := cdsItensNFeBFCPST.AsFloat;
          itemNFe.fltAlqFcpST := cdsItensNFePFCPST.AsFloat;
          itemNFe.fltValFcpST := cdsItensNFeVFCPST.AsFloat;
        End
        Else
        Begin
          itemNFe.fltBasFcpST := 0;
          itemNFe.fltAlqFcpST := 0;
          itemNFe.fltValFcpST := 0;
        End;

      End;

      fatVenda.objNfeComplemento.arrItensNFe[intItem] := itemNfe;
    End;
  Finally
    FreeAndNil(objCalcPisCof);
  End;
end;

end.

