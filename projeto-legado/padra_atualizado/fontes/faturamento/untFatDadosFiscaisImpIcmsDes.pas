unit untFatDadosFiscaisImpIcmsDes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, DB,
  UniClientDataSet, Grids, DBGridCitel, DBGrids, EditFocus, Mask, DBCtrls, DBEditFocus,
  Uni, BitBtnLockedIncrem, Datasnap.DBClient, frxClass, StrUtils,
  frxExportCSVTestabilidade, untTypesSistema, untFuncFat;

type
  TfrmFatDadosFiscaisImpIcmsDes = class(TfrmPaiConfirma)
    dbgItens: TDBGridCitel;
    cdsItens: TUniClientDataSet;
    dtsItens: TDataSource;
    cdsItensAUTOINCREM: TIntegerField;
    cdsItensITE_CODITE: TStringField;
    cdsItensITE_DESITE: TStringField;
    cdsItensITE_REFERE: TStringField;
    cdsItensITE_SIGUNI: TStringField;
    cdsItensITE_CODSIT: TStringField;
    cdsItensITE_TOTITE: TFloatField;
    cdsItensITE_BASICM: TFloatField;
    cdsItensITE_ALQICM: TFloatField;
    cdsItensITE_VALICM: TFloatField;
    cdsItensITE_BASIPI: TFloatField;
    cdsItensITE_ALQIPI: TFloatField;
    cdsItensITE_VALIPI: TFloatField;
    cdsItensITE_BASRET: TFloatField;
    cdsItensITE_VALRET: TFloatField;
    pnlResImp: TPanel;
    Label12: TLabel;
    Panel1: TPanel;
    DBEditFocus1: TDBEditFocus;
    Label9: TLabel;
    DBEditFocus2: TDBEditFocus;
    Panel2: TPanel;
    Panel3: TPanel;
    Label10: TLabel;
    DBEditFocus3: TDBEditFocus;
    ColorDialog1: TColorDialog;
    Label16: TLabel;
    edtVrdIcm: TEditFocus;
    btnDistIcmDes: TBitBtnLocked;
    cdsItensITE_CODABF: TStringField;
    cdsItensITE_ALQPIS: TFloatField;
    cdsItensITE_BASPIS: TFloatField;
    cdsItensITE_VALPIS: TFloatField;
    cdsItensITE_ALQCOF: TFloatField;
    cdsItensITE_BASCOF: TFloatField;
    cdsItensITE_VALCOF: TFloatField;
    cdsItensITE_CLAFIS: TStringField;
    cdsItensITE_CSTPIS: TStringField;
    cdsItensITE_CSTCOF: TStringField;
    cdsItensITE_ALTEROU: TBooleanField;
    cdsItensITE_VRDICM: TFloatField;
    cdsItensITE_DESONE: TStringField;
    cdsItensITE_MTDICM: TStringField;
    cdsItensITE_BASVRD: TFloatField;
    cdsItensITE_SITANT: TStringField;
    procedure cdsItensBeforeInsert(DataSet: TDataSet);
    procedure cdsItensAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cdsItensAfterScroll(DataSet: TDataSet);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnDistIcmDesClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgItensKeyPress(Sender: TObject; var Key: Char);
    procedure dbgItensColExit(Sender: TObject);
    procedure cdsItensITE_DESONEChange(Sender: TField);
  private
    blnValidar: Boolean;
    intRecNo: Integer;
    { Private declarations }

    procedure pPreencheMotivos;
    function fValidaICMSDesonerado: TTipoValidaIcmDes;
    function fRetornaAliquotaItem(strCodIte, strEmpIte: String): Double;
    procedure pOnFilter(DataSet: TDataSet; var Accept: Boolean);
  public
    { Public declarations }
    fatVenda: TFatVenda;
    blnNotImp: Boolean;
    BlnTemXML: Boolean;
    blnEhOutrasSaidasDeFornecedorDevolucao: Boolean;
    function fTotal(strAgg: String): Double;
  end;

  procedure pControlGridFocus(dbgGrid: TDBGridCitel; Key: Word; NextControl: TWinControl);

const
  COR_DESONERADO = $00D2B9EA;

var
  frmFatDadosFiscaisImpIcmsDes: TfrmFatDadosFiscaisImpIcmsDes;

implementation

uses untFuncoesSimples, untConstantes, untFatDadosFiscaisImpDigIcmDes;

{$R *.dfm}

procedure pControlGridFocus(dbgGrid: TDBGridCitel; Key: Word; NextControl: TWinControl);

  function fGetNextColumnField: TField;
    Var
      intIndex: Integer;
  begin
    Result := Nil;
    For intIndex := 0 To dbgGrid.Columns.Count -1 Do
      If intIndex > dbgGrid.SelectedIndex Then
        If Not dbgGrid.Columns[intIndex].ReadOnly Then
        Begin
          Result := dbgGrid.Columns[intIndex].Field;
          Break;
        End;
  end;

  function fGoToNextColumn: Boolean;
  begin
    Result := False;
    If fGetNextColumnField <> nil Then
    Begin
      dbgGrid.SelectedField := fGetNextColumnField;
      dbgGrid.DataSource.DataSet.Edit;
      Result := True;
    End;
  end;

  procedure pNextRecord;
  begin
    dbgGrid.DataSource.DataSet.Next;
    dbgGrid.SelectedIndex := 0;
    dbgGrid.SelectedField := fGetNextColumnField;
    dbgGrid.DataSource.DataSet.Edit;    
  end;

begin
  With dbgGrid, DataSource.DataSet Do
  Begin
    Case Key Of
      VK_RETURN: Begin
                   If State = dsEdit Then
                     Post;

                   If Not fGoToNextColumn Then
                   Begin
                     If RecNo < RecordCount Then
                       pNextRecord
                     Else
                       pSetFocus(NextControl);
                   End;

                 End;
    End;
  End;
end;

function TfrmFatDadosFiscaisImpIcmsDes.fTotal(strAgg: String): Double;
begin
  If (Not cdsItens.Active) Or (cdsItens.Aggregates.Find(strAgg).Value = Null) Then
    Result := 0
  Else
    Result := cdsItens.Aggregates.Find(strAgg).Value;
end;

function TfrmFatDadosFiscaisImpIcmsDes.fValidaICMSDesonerado: TTipoValidaIcmDes;
  Var
    prcScroll: TprcScroll;
begin
  Result := idNone;

  With cdsItens Do
  Begin
    If Not IsEmpty Then
    Begin
      If State = dsEdit Then
        Post;

      pDisableControls(cdsItens, prcScroll);
      First;

      While Not Eof Do
      Begin
        If FieldByName('ITE_DESONE').AsString = 'Sim' Then
        Begin
          If fEmptyStr(FieldByName('ITE_MTDICM').AsString) Then
          Begin
            Result := idMotivo;
            Break;
          End;

          If FieldByName('ITE_VRDICM').AsFloat <= 0 Then
          Begin
            Result := idIcms;
            Break;
          End;
        End;

        Next;
      End;

      pEnableControls(cdsItens, prcScroll);
    End;
  End;
end;

procedure TfrmFatDadosFiscaisImpIcmsDes.pOnFilter(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := Pos(DataSet.FieldByName('ITE_CODSIT').AsString, CST_NAO_APLICA_ICMS_DESONERADO) <= 0;
end;

procedure TfrmFatDadosFiscaisImpIcmsDes.pPreencheMotivos;
begin
  fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Clear;

  If cdsItens.FieldByName('ITE_DESONE').AsString = 'Sim' Then
  Begin
    If (Pos(cdsItens.FieldByName('ITE_SITANT').AsString, CST_SUBSTITUICAO + '090_190_290_390_490_590_690_790_890_') > 0) Then
    Begin
      fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Add('6 - Utilitários e Motocicletas da Amazônia Ocidental e Áreas de Livre Comércio (Resolução 714/88 e 790/94 - CONTRAN e suas alterações)');
      fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Add('7 - SUFRAMA');
      fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Add('9 - Outros');
    End
    Else If (Pos(Copy(cdsItens.FieldByName('ITE_SITANT').AsString, 2, 2), '20_') > 0) Then
    Begin
      fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Add('3 - Uso na agropecuária');
      fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Add('9 - Outros');
      fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Add('12 - Órgãos de fomento e desenvolvimento agropecuário');
    End
    Else If blnEhOutrasSaidasDeFornecedorDevolucao And (Pos(Copy(cdsItens.FieldByName('ITE_SITANT').AsString, 2, 2), '30_40_41_50_') > 0) Then
    Begin
      fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Add('9 - Outros (NT 2011-004)');
    End
    Else
    Begin
      fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Add('1 - Táxi');
      fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Add('2 - Deficiente Físico');
      fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Add('3 - Produtor / Agropecuário');
      fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Add('4 - Frotista / Locadora');
      fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Add('5 - Diplomático / Consular');
      fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Add('6 - Utilitários e Motocicletas da Amazônia Ocidental e Áreas de Livre Comércio (Resolução 714/88 e 790/94 - CONTRAN e suas alterações)');
      fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Add('7 - SUFRAMA');
      fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Add('8 - Venda a Órgão Público');
      fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Add('9 - Outros (NT 2011-004)');
      fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Add('10 - Deficiente Condutor (Convênio ICMS 38/12)');
      fFindColumnByName(dbgItens, 'ITE_MTDICM').PickList.Add('11 - Deficiente Não Condutor (Convênio ICMS 38/12)');
    End;
  End;
end;

procedure TfrmFatDadosFiscaisImpIcmsDes.btnConfirmaClick(Sender: TObject);
  Var
    idValidaIcmsDes: TTipoValidaIcmDes;
begin
  //inherited;

  idValidaIcmsDes := fValidaICMSDesonerado;

  If idValidaIcmsDes = idMotivo Then
    fMensagem('ATENÇÃO', 'Defina o motivo dos itens que serão desonerados!', ['&OK'])
  Else
    ModalResult := mrOk;
end;

function TfrmFatDadosFiscaisImpIcmsDes.fRetornaAliquotaItem(strCodIte, strEmpIte: String): Double;
Var
  fltAlqIcm: Double;
  strCodSit: String;
Begin
  fltAlqIcm := 0;

  If (Assigned(fatVenda)) Then
    fatVenda.pRetornaAliquotaItem(strCodIte, strEmpIte, fltAlqIcm, strCodSit);

  Result := fltAlqIcm;
End;

procedure TfrmFatDadosFiscaisImpIcmsDes.btnDistIcmDesClick(Sender: TObject);
  Var
    strIcmDes,
    strMtdIcmST,
    strMtdIcm020,
    strMtdIcmNaoST: String;
    prcScroll: TprcScroll;

//    fltIcmOpe,
//    fltVrdIcm: Double;
begin
  blnValidar := False;

  If fPedeDigitacaoDadosICMSDesonerado(strIcmDes, strMtdIcmST, strMtdIcmNaoST, strMtdIcm020) Then
  Begin
    With cdsItens Do
    Begin
      pDisableControls(cdsItens, prcScroll);
      First;

      While Not Eof Do
      Begin
        Edit;

        If strIcmDes = 'N' Then
        Begin
          FieldByName('ITE_CODSIT').AsString := FieldByName('ITE_SITANT').AsString;
          FieldByName('ITE_MTDICM').AsString := '';
          FieldByName('ITE_DESONE').AsString := 'Não';
          FieldByName('ITE_VRDICM').AsFloat  := 0.0;
          FieldByName('ITE_BASVRD').AsFloat  := 0.0;
        End
        Else
        Begin
          FieldByName('ITE_DESONE').AsString := 'Sim';

          If (Pos(FieldByName('ITE_CODSIT').AsString, CST_SUBSTITUICAO + '090_190_290_390_490_590_690_790_890_') > 0) Then
          Begin
            If not BlnTemXML Then
              FieldByName('ITE_CODSIT').AsString := LeftStr(FieldByName('ITE_CODSIT').AsString, 1) + '30';

            FieldByName('ITE_MTDICM').AsString := strMtdIcmST;
          End
          Else
          Begin
            FieldByName('ITE_CODSIT').AsString := FieldByName('ITE_CODSIT').AsString;

            If (Pos(Copy(FieldByName('ITE_CODSIT').AsString, 2, 2), '20_') > 0) Then
              FieldByName('ITE_MTDICM').AsString := strMtdIcm020
            Else
              FieldByName('ITE_MTDICM').AsString := strMtdIcmNaoST;
          End;

//          fltIcmOpe := ((FieldByName('ITE_BASICM').AsFloat * 0.70) * (FieldByName('ITE_ALQICM').AsFloat / 100));
//          fltVrdIcm := (FieldByName('ITE_BASICM').AsFloat * (FieldByName('ITE_ALQICM').AsFloat / 100)) - fltIcmOpe;
//          FieldByName('ITE_VRDICM').AsFloat := fltVrdIcm;
//          FieldByName('ITE_BASVRD').AsFloat := FieldByName('ITE_BASICM').AsFloat;

          If blnNotImp Then
          begin
            FieldByName('ITE_VRDICM').AsFloat := (FieldByName('ITE_TOTITE').AsFloat * fRetornaAliquotaItem(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_EMPITE').AsString)) / 100;
            FieldByName('ITE_BASVRD').AsFloat := FieldByName('ITE_TOTITE').AsFloat;
          End
          Else
          Begin
            FieldByName('ITE_VRDICM').AsFloat := FieldByName('ITE_VRDICM').OldValue;
            FieldByName('ITE_BASVRD').AsFloat := FieldByName('ITE_BASICM').AsFloat;
          End;

        End;

        Post;
        Next;
      End;

      pEnableControls(cdsItens, prcScroll);
      First;
    End;
  End;

  blnValidar := True;
end;

procedure TfrmFatDadosFiscaisImpIcmsDes.cdsItensAfterPost(DataSet: TDataSet);
begin
  inherited;
  edtVrdIcm.Text := FormatFloat('#,##0.00', fTotal('AGG_VRDICM'));

  pPreencheMotivos;
end;

procedure TfrmFatDadosFiscaisImpIcmsDes.cdsItensAfterScroll(DataSet: TDataSet);
begin
  inherited;
  intRecNo := DataSet.RecNo;

  pPreencheMotivos;
end;

procedure TfrmFatDadosFiscaisImpIcmsDes.cdsItensBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  If blnValidar Then
  Begin
    DataSet.Cancel;
    Abort;
  End;
end;

procedure TfrmFatDadosFiscaisImpIcmsDes.cdsItensITE_DESONEChange(Sender: TField);
//  Var
//    fltIcmOpe,
//    fltVrdIcm: Double;
begin
  inherited;

  If Sender.AsString = 'Não' Then
  Begin
    cdsItens.FieldByName('ITE_CODSIT').AsString := cdsItens.FieldByName('ITE_SITANT').AsString;
    cdsItens.FieldByName('ITE_MTDICM').AsString := '';
    cdsItens.FieldByName('ITE_VRDICM').AsFloat  := 0.0;
    cdsItens.FieldByName('ITE_BASVRD').AsFloat  := 0.0;
  End
  Else
  Begin
    If (Pos(cdsItens.FieldByName('ITE_CODSIT').AsString, CST_SUBSTITUICAO + '090_190_290_390_490_590_690_790_890_') > 0) And (not BlnTemXML) Then
      cdsItens.FieldByName('ITE_CODSIT').AsString := LeftStr(cdsItens.FieldByName('ITE_CODSIT').AsString, 1) + '30';

//    fltIcmOpe := ((cdsItens.FieldByName('ITE_BASICM').AsFloat * 0.70) * (cdsItens.FieldByName('ITE_ALQICM').AsFloat / 100));
//    fltVrdIcm := (cdsItens.FieldByName('ITE_BASICM').AsFloat * (cdsItens.FieldByName('ITE_ALQICM').AsFloat / 100)) - fltIcmOpe;
//    cdsItens.FieldByName('ITE_VRDICM').AsFloat := fltVrdIcm;
//    cdsItens.FieldByName('ITE_BASVRD').AsFloat := cdsItens.FieldByName('ITE_BASICM').AsFloat;

    If not blnNotImp Then
    Begin
      cdsItens.FieldByName('ITE_VRDICM').AsFloat := cdsItens.FieldByName('ITE_VRDICM').OldValue;
      cdsItens.FieldByName('ITE_BASVRD').AsFloat := cdsItens.FieldByName('ITE_BASICM').AsFloat;
    End;
  End;
end;

procedure TfrmFatDadosFiscaisImpIcmsDes.dbgItensColExit(Sender: TObject);
begin
  inherited;

  If cdsItens.State = dsEdit Then
    cdsItens.Post;
end;

procedure TfrmFatDadosFiscaisImpIcmsDes.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If Not cdsItens.Active Then
    Exit;

  If Pos(Column.FieldName, 'ITE_VRDICM_ITE_MTDICM_') > 0 Then
    dbgItens.Canvas.Brush.Color := COR_DESONERADO;

  If (cdsItens.RecNo = intRecNo) Then
  Begin
    dbgItens.Canvas.Brush.Color := clBlue;
    dbgItens.Canvas.Font.Color  := clWhite;
  End;

  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFatDadosFiscaisImpIcmsDes.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pControlGridFocus(dbgItens, Key, btnConfirma);
end;

procedure TfrmFatDadosFiscaisImpIcmsDes.dbgItensKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (dbgItens.SelectedField.FieldName <> 'ITE_VRDICM') Or (cdsItens.FieldByName('ITE_DESONE').AsString = 'Não') Then
    Key := #0;
end;

procedure TfrmFatDadosFiscaisImpIcmsDes.FormCreate(Sender: TObject);
begin
  inherited;
  fatVenda := Nil;
  blnNotImp := False;
  blnValidar := True;
  pSetaCodIte(cdsItensITE_CODITE);
  cdsItensITE_REFERE.Size := fTamRefere;
  cdsItens.CreateDataSet;
end;

procedure TfrmFatDadosFiscaisImpIcmsDes.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case key Of
    VK_F10: btnConfirma.Click;
    VK_F3 : btnDistIcmDes.Click;

    VK_RETURN: If ((ActiveControl) = dbgItens) And (cdsItens.State = dsEdit) Then
               Begin
                 cdsItens.Post;
               End;
  End;
end;

procedure TfrmFatDadosFiscaisImpIcmsDes.FormShow(Sender: TObject);
begin
  inherited;
  cdsItens.OnFilterRecord := pOnFilter;
  cdsItens.Filtered := True;

  cdsItens.First;
  pSetFocus(dbgItens);
  dbgItens.SelectedField := cdsItens.FieldByName('ITE_DESONE');

  cdsItens.Active := False;
  cdsItens.Active := True;
  cdsItensAfterPost(cdsItens);

end;

end.
