{******************************************}
{* qryCst_Pis_Cof -> PESQUISA CST/PIS/COF *}
{******************************************}
unit untFatDadosFiscaisImpPisCofins;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, DB,
  UniClientDataSet, Grids, DBGridCitel, DBGrids, EditFocus, Mask, DBCtrls, DBEditFocus,
  Uni, BitBtnLockedIncrem, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade, untTypesSistema;

type
  TfrmFatDadosFiscaisImpPisCofins = class(TfrmPaiConfirma)
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
    Label1: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edtBasPis: TEditFocus;
    edtBasCof: TEditFocus;
    edtValPis: TEditFocus;
    edtValCof: TEditFocus;
    btnZerarPis: TBitBtnLocked;
    btnZerarCof: TBitBtnLocked;
    btnInfCof: TBitBtnLocked;
    btnInfPis: TBitBtnLocked;
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
    cdsItensITE_MTDICM: TStringField;
    cdsItensITE_DESONE: TStringField;
    cdsItensITE_BASVRD: TFloatField;
    procedure cdsItensBeforeInsert(DataSet: TDataSet);
    procedure cdsItensBeforePost(DataSet: TDataSet);
    procedure cdsItensAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnZerarPisClick(Sender: TObject);
    procedure btnZerarCofClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cdsItensAfterScroll(DataSet: TDataSet);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnInfPisClick(Sender: TObject);
    procedure btnInfCofClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgItensKeyPress(Sender: TObject; var Key: Char);
  private
    blnValidar: Boolean;
    intRecNo: Integer;
    qryCst_Pis_Cof: TUniQuery;

    procedure pSetaCstPisCofins;
    function fRetCstPisCofinsInterna(strClaFis, strCodSit, strIncPis, strSitP_C, strMenP_C: String;
                                     fltValPis: Double): String;

    function fValidaCST_Pis_Cof : Boolean;
    { Private declarations }
  public
    { Public declarations }
    blnNotaFornecedor: Boolean;
    strCodigoFornecedor: String;
    strSitP_C: String;
    strMenP_C: String;
    blnNotImp: Boolean;
    function fTotal(strAgg: String): Double;
  end;

  procedure pControlGridFocus(dbgGrid: TDBGridCitel; Key: Word; NextControl: TWinControl);

const
  COR_PIS    = 10944511;
  COR_COFINS = 13434828;
var
  frmFatDadosFiscaisImpPisCofins: TfrmFatDadosFiscaisImpPisCofins;

implementation

uses untFuncoesSimples, untFatDadosFiscaisImpDigValores, untConsultas, untGeralPisCofins;

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

function TfrmFatDadosFiscaisImpPisCofins.fTotal(strAgg: String): Double;
begin
  If (Not cdsItens.Active) Or (cdsItens.Aggregates.Find(strAgg).Value = Null) Then
    Result := 0
  Else
    Result := cdsItens.Aggregates.Find(strAgg).Value;
end;

function TfrmFatDadosFiscaisImpPisCofins.fValidaCST_Pis_Cof: Boolean;
  Var
  strCST_Nao_Valida: String;
  strTipo_Entrada_Saida: String;
  strMin: String;
  strMax: String;
begin
  Result := True;
  strCST_Nao_Valida     := '';
  strTipo_Entrada_Saida := '';
  strMin := '';
  strMax := '';
  //Somente se alterou
   If cdsItens.FieldByName('ITE_ALTEROU').AsBoolean Then
   Begin
     //Valida Saída
     If (cdsItens.FieldByName('ITE_CLAFIS').AsString >= '5000') Then
     Begin
       If (Not fValidaEscala(cdsItens.FieldByName('ITE_CSTPIS').AsString,01,49)) Then
         strCST_Nao_Valida := cdsItens.FieldByName('ITE_CSTPIS').AsString
       Else If (Not fValidaEscala(cdsItens.FieldByName('ITE_CSTCOF').AsString,01,49)) Then
         strCST_Nao_Valida := cdsItens.FieldByName('ITE_CSTCOF').AsString;

       strTipo_Entrada_Saida := 'SAÍDA';
       strMin := '01';
       strMax := '49';
     End;

      //Valida Entrada
      If (cdsItens.FieldByName('ITE_CLAFIS').AsString < '5000') Then
      Begin
        If Not fValidaEscala(cdsItens.FieldByName('ITE_CSTPIS').AsString,50,99) Then
          strCST_Nao_Valida := cdsItens.FieldByName('ITE_CSTPIS').AsString
        Else If Not fValidaEscala(cdsItens.FieldByName('ITE_CSTCOF').AsString,50,99) Then
          strCST_Nao_Valida := cdsItens.FieldByName('ITE_CSTCOF').AsString;

        strTipo_Entrada_Saida := 'ENTRADA';
        strMin := '50';
        strMax := '99';
      End;

      If Not fEmptyStr(strCST_Nao_Valida) Then
      Begin
        fMensagem('','CST '+strCST_Nao_Valida+ ' não pode ser utilizada em operações de ' +
                  strTipo_Entrada_Saida+'.'+#13#10+'CST''S válidas: intervalo de '+strMin   +
                  ' a '+strMax+'.', ['&Ok']);
        Result := False;
      End;

      If (Result) And
         (Pos(cdsItens.FieldByName('ITE_CSTPIS').AsString,'05_07_08_09_70_71_72_74') > 0) And
         (cdsItens.FieldByName('ITE_BASPIS').AsFloat > 0)Then
      Begin
        fMensagem('', 'CST '+cdsItens.FieldByName('ITE_CSTPIS').AsString+' só permite base de PIS zerada', ['&Ok']);
        Result := False;
      End
      Else If (Result) And
           (Pos(cdsItens.FieldByName('ITE_CSTCOF').AsString,'05_07_08_09_70_71_72_74') > 0) And
           (cdsItens.FieldByName('ITE_BASCOF').AsFloat > 0)   Then
      Begin
        fMensagem('', 'CST '+cdsItens.FieldByName('ITE_CSTCOF').AsString+' só permite base de  COFINS zerada', ['&Ok']);
        Result := False;
      End;

      If (Result) And
         (Pos(cdsItens.FieldByName('ITE_CSTCOF').AsString,'04_05_06_07_08_09_70_71_72_74') > 0) And
         (cdsItens.FieldByName('ITE_ALQCOF').AsFloat > 0) Then
      Begin
        fMensagem('', 'CST '+cdsItens.FieldByName('ITE_CSTCOF').AsString+' só permite alíquota de COFINS zerada', ['&Ok']);
        Result := False;
      End
      Else If (Result) And
             (Pos(cdsItens.FieldByName('ITE_CSTPIS').AsString,'04_05_06_07_08_09_70_71_72_74') > 0) And
             (cdsItens.FieldByName('ITE_ALQPIS').AsFloat > 0) Then
      Begin
        fMensagem('', 'CST '+cdsItens.FieldByName('ITE_CSTPIS').AsString+' só permite alíquota de PIS zerada', ['&Ok']);
        Result := False;
      End;
    End;
end;

procedure TfrmFatDadosFiscaisImpPisCofins.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryCst_Pis_Cof);
  ModalResult := mrOk;
end;

procedure TfrmFatDadosFiscaisImpPisCofins.btnInfPisClick(Sender: TObject);
  var
    fltBasPis,
    fltAlqPis,
    fltValPis,
    fltTotPro,
    fltPerCor: Double;
begin
  //inherited;

  fltTotPro := fTotal('AGG_TOTITE');

  If (Not btnInfPis.Visible) Or (fltTotPro <= 0) Then
    Exit;

  blnValidar := False;

  If fPedeDigitacaoValoresImpost(fltBasPis, fltAlqPis, fltValPis, 'Total do PIS', True) Then
  Begin
    With cdsItens Do
    Begin
      First;
      While Not Eof Do
      Begin
        fltPerCor := FieldByName('ITE_TOTITE').AsFloat / fltTotPro;

        Edit;
        FieldByName('ITE_ALQPIS').AsFloat := fltAlqPis;
        FieldByName('ITE_BASPIS').AsFloat := fFormataFloat(fltBasPis * fltPerCor, 2);
        FieldByName('ITE_VALPIS').AsFloat := fFormataFloat(fltValPis * fltPerCor, 2);
        Post;

        Next;
      End;
      First;

      Edit;
      FieldByName('ITE_BASPIS').AsFloat := FieldByName('ITE_BASPIS').AsFloat + (fFormataFloat(fltBasPis, 2) - fTotal('AGG_BASPIS'));
      FieldByName('ITE_VALPIS').AsFloat := FieldByName('ITE_VALPIS').AsFloat + (fFormataFloat(fltValPis, 2) - fTotal('AGG_VALPIS'));
      Post;
    End;
  End;

  blnValidar := True;

end;

procedure TfrmFatDadosFiscaisImpPisCofins.btnInfCofClick(Sender: TObject);
  var
    fltBasCof,
    fltAlqCof,
    fltValCof,
    fltTotPro,
    fltPerCor: Double;
begin
  inherited;

  fltTotPro := fTotal('AGG_TOTITE');

  If (Not btnInfCof.Visible) Or (fltTotPro <= 0) Then
    Exit;

  blnValidar := False;

  If fPedeDigitacaoValoresImpost(fltBasCof, fltAlqCof, fltValCof, 'Total do Cofins', True) Then
  Begin
    With cdsItens Do
    Begin
      First;
      While Not Eof Do
      Begin
        fltPerCor := FieldByName('ITE_TOTITE').AsFloat / fltTotPro;

        Edit;
        FieldByName('ITE_ALQCOF').AsFloat := fltAlqCof;
        FieldByName('ITE_BASCOF').AsFloat := fFormataFloat(fltBasCof * fltPerCor, 2);
        FieldByName('ITE_VALCOF').AsFloat := fFormataFloat(fltValCof * fltPerCor, 2);
        Post;

        Next;
      End;
      First;

      Edit;
      FieldByName('ITE_BASCOF').AsFloat := FieldByName('ITE_BASCOF').AsFloat + (fFormataFloat(fltBasCof, 2) - fTotal('AGG_BASCOF'));
      FieldByName('ITE_VALCOF').AsFloat := FieldByName('ITE_VALCOF').AsFloat + (fFormataFloat(fltValCof, 2) - fTotal('AGG_VALCOF'));
      Post;
    End;
  End;

  blnValidar := True;

end;

procedure TfrmFatDadosFiscaisImpPisCofins.btnZerarPisClick(Sender: TObject);
begin
  inherited;
  blnValidar := False;
  With cdsItens Do
  Begin
    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('ITE_BASPIS').AsFloat := 0;
      FieldByName('ITE_ALQPIS').AsFloat := 0;
      FieldByName('ITE_VALPIS').AsFloat := 0;
      Post;
      Next;
    End;
    First;
  End;
  blnValidar := True;
end;

procedure TfrmFatDadosFiscaisImpPisCofins.btnZerarCofClick(Sender: TObject);
begin
  inherited;
  blnValidar := False;
  With cdsItens Do
  Begin
    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('ITE_BASCOF').AsFloat := 0;
      FieldByName('ITE_ALQCOF').AsFloat := 0;
      FieldByName('ITE_VALCOF').AsFloat := 0;
      Post;
      Next;
    End;
    First;
  End;
  blnValidar := True;
end;

procedure TfrmFatDadosFiscaisImpPisCofins.cdsItensAfterPost(DataSet: TDataSet);
begin
  inherited;
  edtBasPis.Text := FormatFloat('#,##0.00', fTotal('AGG_BASPIS'));
  edtValPis.Text := FormatFloat('#,##0.00', fTotal('AGG_VALPIS'));
  edtBasCof.Text := FormatFloat('#,##0.00', fTotal('AGG_BASCOF'));
  edtValCof.Text := FormatFloat('#,##0.00', fTotal('AGG_VALCOF'));
end;

procedure TfrmFatDadosFiscaisImpPisCofins.cdsItensAfterScroll(DataSet: TDataSet);
begin
  inherited;
  intRecNo := DataSet.RecNo;
end;

procedure TfrmFatDadosFiscaisImpPisCofins.cdsItensBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  If blnValidar Then
  Begin
    DataSet.Cancel;
    Abort;
  End;
end;

procedure TfrmFatDadosFiscaisImpPisCofins.cdsItensBeforePost(DataSet: TDataSet);
  function fValidaValor(strCampo: String): Boolean;
  begin
    Result := DataSet.FieldByName(strCampo).AsFloat >= 0;
    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'O Campo ' + DataSet.FieldByName(strCampo).DisplayLabel +
                ' deve ser maior ou igual à zero!', ['&Ok']);
    End;
  end;

  function fValidaBaseValor(strBase, strValor: String): Boolean;
  begin
    Result := True;

    If (DataSet.FieldByName(strBase).AsFloat = 0) And
       (DataSet.FieldByName(strValor).AsFloat > 0) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'O Campo ' + DataSet.FieldByName(strBase).DisplayLabel +
                ' deve ser informado!', ['&Ok']);
    End;

  end;

  procedure pCalculaValor(strBase, strAlq, strValor: String);
  begin
    If DataSet.State = dsEdit Then
    Begin
      DataSet.FieldByName(strValor).AsFloat :=
        fFormataFloat(DataSet.FieldByName(strBase).AsFloat * DataSet.FieldByName(strAlq).AsFloat / 100, 2);
    End;
  end;

begin
  inherited;

  If Not blnValidar Then
    Exit;

  pCalculaValor('ITE_BASPIS', 'ITE_ALQPIS', 'ITE_VALPIS');
  pCalculaValor('ITE_BASCOF', 'ITE_ALQCOF', 'ITE_VALCOF');
  pSetaCstPisCofins;

  If Not (fValidaValor('ITE_BASPIS')  And
          fValidaValor('ITE_ALQPIS')  And
          fValidaValor('ITE_VALPIS')  And
          fValidaValor('ITE_BASCOF')  And
          fValidaValor('ITE_ALQCOF')  And
          fValidaValor('ITE_VALCOF')) Then
  Begin
    DataSet.Cancel;
    Abort;
  End;

  If Not (fValidaBaseValor('ITE_BASPIS', 'ITE_BASPIS')  And
          fValidaBaseValor('ITE_BASCOF', 'ITE_VALCOF')) Then
  Begin
    DataSet.Cancel;
    Abort;
  End;

  If (Not blnNotImp) Then
    If (Not fValidaCST_Pis_Cof) Then
    Begin
      DataSet.Cancel;
      Abort;
    End;

end;

procedure TfrmFatDadosFiscaisImpPisCofins.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If Not cdsItens.Active Then
    Exit;

  If Pos(Column.FieldName, 'ITE_BASPIS_ITE_ALQPIS_ITE_VALPIS_ITE_CSTPIS_') > 0 Then
    dbgItens.Canvas.Brush.Color := COR_PIS;

  If Pos(Column.FieldName, 'ITE_BASCOF_ITE_ALQCOF_ITE_VALCOF_ITE_CSTCOF_') > 0 Then
    dbgItens.Canvas.Brush.Color := COR_COFINS;

  If (cdsItens.RecNo = intRecNo) Then
  Begin
    dbgItens.Canvas.Brush.Color := clBlue;
    dbgItens.Canvas.Font.Color  := clWhite;
  End;

  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmFatDadosFiscaisImpPisCofins.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pControlGridFocus(dbgItens, Key, btnConfirma);
end;

procedure TfrmFatDadosFiscaisImpPisCofins.dbgItensKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  With dbgItens, cdsItens Do
  Begin
    If (dbgItens.SelectedField.FieldName = 'ITE_CSTCOF') Then
    Begin
      If fEntraCons(Key) Then
      Begin
        If fPesqCSTCof(Self,Nil,Nil, qryCst_Pis_Cof, Key, arrSel) Then
        Begin
          If State <> dsEdit Then
            Edit;

          cdsItens.FieldByName('ITE_CSTCOF').AsString := qryCst_Pis_Cof.FieldByName('CST_CODCST').AsString;
          cdsItens.FieldByName('ITE_ALTEROU').Value   := True;
          Post;
        End;
      End
      Else
        Key := #0;
    End;

    If (dbgItens.SelectedField.FieldName = 'ITE_CSTPIS') Then
    Begin
      If fEntraCons(Key) Then
      Begin
        If fPesqCSTPis(Self,Nil, Nil, qryCst_Pis_Cof, Key, arrSel) Then
        Begin
          If State <> dsEdit Then
            Edit;

          cdsItens.FieldByName('ITE_CSTPIS').AsString := qryCst_Pis_Cof.FieldByName('CST_CODCST').AsString;
          cdsItens.FieldByName('ITE_ALTEROU').Value   := True;
          Post;
        End;
      End
      Else
        Key := #0;
    End;
  End;
end;

procedure TfrmFatDadosFiscaisImpPisCofins.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(cdsItensITE_CODITE);
  blnValidar        := True;
  blnNotaFornecedor := False;
  cdsItensITE_REFERE.Size := fTamRefere;
  cdsItens.CreateDataSet;
  qryCst_Pis_Cof := fCriaQuery;
  blnNotImp := False;
end;

procedure TfrmFatDadosFiscaisImpPisCofins.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case key Of
    VK_F10: btnConfirma.Click;
    VK_F2 : btnZerarPis.Click;
    VK_F3 : btnZerarCof.Click;
    VK_F5 : btnInfPis.Click;
    VK_F6 : btnInfCof.Click;

    VK_RETURN: If ((ActiveControl) = dbgItens) And (cdsItens.State = dsEdit) Then
               Begin
                 cdsItens.Post;
               End;
  End;
end;

procedure TfrmFatDadosFiscaisImpPisCofins.FormShow(Sender: TObject);
begin
  inherited;
  btnInfCof.Visible := blnNotaFornecedor;
  btnInfPis.Visible := blnNotaFornecedor;

  If Not blnNotaFornecedor Then
  Begin
    //pnlBotoes.Height := pnlBotoes.Height - btnInfCof.Height;
    //btnSair.Top      := btnConfirma.Top;
  End;

  cdsItens.First;
  pSetFocus(dbgItens);
  dbgItens.SelectedField := cdsItens.FieldByName('ITE_CSTPIS');

  cdsItens.Active := False;
  cdsItens.Active := True;
  cdsItensAfterPost(cdsItens);

end;

procedure TfrmFatDadosFiscaisImpPisCofins.pSetaCstPisCofins;
Begin
  If (Not cdsItens.FieldByName('ITE_ALTEROU').AsBoolean) Then
  Begin
    cdsItens.FieldByName('ITE_CSTPIS').AsString := fRetCstPisCofinsInterna(cdsItens.FieldByName('ITE_CLAFIS').AsString,
                                                                           cdsItens.FieldByName('ITE_CODSIT').AsString,
                                                                           IIF(cdsItens.FieldByName('ITE_VALPIS').AsFloat > 0, 'S', 'N'),
                                                                           strSitP_C, strMenP_C,
                                                                           cdsItens.FieldByName('ITE_VALPIS').AsFloat);

    cdsItens.FieldByName('ITE_CSTCOF').AsString := fRetCstPisCofinsInterna(cdsItens.FieldByName('ITE_CLAFIS').AsString,
                                                                           cdsItens.FieldByName('ITE_CODSIT').AsString,
                                                                           IIF(cdsItens.FieldByName('ITE_VALCOF').AsFloat > 0, 'S', 'N'),
                                                                           strSitP_C, strMenP_C,
                                                                           cdsItens.FieldByName('ITE_VALCOF').AsFloat);
  End;
End;

function TfrmFatDadosFiscaisImpPisCofins.fRetCstPisCofinsInterna(strClaFis, strCodSit, strIncPis, strSitP_C, strMenP_C: String; fltValPis: Double): String;
begin
 If fltValPis > 0 Then
   Result := '01'
 Else
   Result := fRetCstPisCofins(strClaFis, strCodSit, strIncPis, strSitP_C, strMenP_C);
end;

end.
