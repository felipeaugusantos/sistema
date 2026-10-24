{******************************************}
{* qryIPI -> PESQUISA IPI *}
{******************************************}
unit untFatDadosFiscaisImpIPI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, DB,
  UniClientDataSet, Grids, DBGridCitel, DBGrids, EditFocus, Mask, DBCtrls, DBEditFocus,
  Uni, BitBtnLockedIncrem, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade, untTypesSistema;

type
  TfrmFatDadosFiscaisImpIPI = class(TfrmPaiConfirma)
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
    Label15: TLabel;
    edtBasIPI: TEditFocus;
    edtValIPI: TEditFocus;
    btnZerarIPI: TBitBtnLocked;
    btnInfIPI: TBitBtnLocked;
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
    procedure btnZerarIPIClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cdsItensAfterScroll(DataSet: TDataSet);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnInfIPIClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    blnValidar: Boolean;
    intRecNo: Integer;
    qryIPI: TUniQuery;

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
  COR_IPI    = 13434828;

var
  frmFatDadosFiscaisImpIPI: TfrmFatDadosFiscaisImpIPI;

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

function TfrmFatDadosFiscaisImpIPI.fTotal(strAgg: String): Double;
begin
  If (Not cdsItens.Active) Or (cdsItens.Aggregates.Find(strAgg).Value = Null) Then
    Result := 0
  Else
    Result := cdsItens.Aggregates.Find(strAgg).Value;
end;

procedure TfrmFatDadosFiscaisImpIPI.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryIPI);
  ModalResult := mrOk;
end;

procedure TfrmFatDadosFiscaisImpIPI.btnInfIPIClick(Sender: TObject);
  var
    fltBasIPI,
    fltAlqIPI,
    fltValIPI,
    fltTotPro,
    fltPerCor: Double;
begin

  fltTotPro := fTotal('AGG_TOTITE');

  If (Not btnInfIPI.Visible) Or (fltTotPro <= 0) Then
    Exit;

  blnValidar := False;

  If fPedeDigitacaoValoresImpost(fltBasIPI, fltAlqIPI, fltValIPI, 'Total do IPI', True) Then
  Begin
    With cdsItens Do
    Begin
      First;
      While Not Eof Do
      Begin
        fltPerCor := FieldByName('ITE_TOTITE').AsFloat / fltTotPro;

        Edit;
        FieldByName('ITE_ALQIPI').AsFloat := fltAlqIPI;
        FieldByName('ITE_BASIPI').AsFloat := fFormataFloat(fltBasIPI * fltPerCor, 2);
        FieldByName('ITE_VALIPI').AsFloat := fFormataFloat(fltValIPI * fltPerCor, 2);
        Post;

        Next;
      End;
      First;

      Edit;
      FieldByName('ITE_BASIPI').AsFloat := FieldByName('ITE_BASIPI').AsFloat + (fFormataFloat(fltBasIPI, 2) - fTotal('AGG_BASIPI'));
      FieldByName('ITE_VALIPI').AsFloat := FieldByName('ITE_VALIPI').AsFloat + (fFormataFloat(fltValIPI, 2) - fTotal('AGG_VALIPI'));
      Post;
    End;
  End;

  blnValidar := True;

end;


procedure TfrmFatDadosFiscaisImpIPI.btnZerarIPIClick(Sender: TObject);
begin
  inherited;
  blnValidar := False;
  With cdsItens Do
  Begin
    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('ITE_BASIPI').AsFloat := 0;
      FieldByName('ITE_ALQIPI').AsFloat := 0;
      FieldByName('ITE_VALIPI').AsFloat := 0;
      Post;
      Next;
    End;
    First;
  End;
  blnValidar := True;
end;

procedure TfrmFatDadosFiscaisImpIPI.cdsItensAfterPost(DataSet: TDataSet);
begin
  inherited;
  edtBasIPI.Text := FormatFloat('#,##0.00', fTotal('AGG_BASIPI'));
  edtValIPI.Text := FormatFloat('#,##0.00', fTotal('AGG_VALIPI'));
end;

procedure TfrmFatDadosFiscaisImpIPI.cdsItensAfterScroll(DataSet: TDataSet);
begin
  inherited;
  intRecNo := DataSet.RecNo;
end;

procedure TfrmFatDadosFiscaisImpIPI.cdsItensBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  If blnValidar Then
  Begin
    DataSet.Cancel;
    Abort;
  End;
end;

procedure TfrmFatDadosFiscaisImpIPI.cdsItensBeforePost(DataSet: TDataSet);
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

  pCalculaValor('ITE_BASIPI', 'ITE_ALQIPI', 'ITE_VALIPI');

  If Not (fValidaValor('ITE_BASIPI')  And
          fValidaValor('ITE_ALQIPI')  And
          fValidaValor('ITE_VALIPI') ) Then
  Begin
    DataSet.Cancel;
    Abort;
  End;

  If Not fValidaBaseValor('ITE_BASIPI', 'ITE_BASIPI') Then
  Begin
    DataSet.Cancel;
    Abort;
  End;

end;

procedure TfrmFatDadosFiscaisImpIPI.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If Not cdsItens.Active Then
    Exit;

  If Pos(Column.FieldName, 'ITE_BASIPI_ITE_ALQIPI_ITE_VALIPI') > 0 Then
    dbgItens.Canvas.Brush.Color := COR_IPI;


  If (cdsItens.RecNo = intRecNo) Then
  Begin
    dbgItens.Canvas.Brush.Color := clBlue;
    dbgItens.Canvas.Font.Color  := clWhite;
  End;

  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmFatDadosFiscaisImpIPI.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pControlGridFocus(dbgItens, Key, btnConfirma);
end;

procedure TfrmFatDadosFiscaisImpIPI.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(cdsItensITE_CODITE);
  blnValidar        := True;
  blnNotaFornecedor := False;
  cdsItensITE_REFERE.Size := fTamRefere;
  cdsItens.CreateDataSet;
  qryIPI := fCriaQuery;
  blnNotImp := False;
end;

procedure TfrmFatDadosFiscaisImpIPI.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case key Of
    VK_F10: btnConfirma.Click;
    VK_F2 : btnZerarIPI.Click;
    VK_F5 : btnInfIPI.Click;
    VK_RETURN: If ((ActiveControl) = dbgItens) And (cdsItens.State = dsEdit) Then
               Begin
                 cdsItens.Post;
               End;
  End;
end;

procedure TfrmFatDadosFiscaisImpIPI.FormShow(Sender: TObject);
begin
  inherited;
  btnInfIPI.Visible := blnNotaFornecedor;

  If Not blnNotaFornecedor Then
  Begin
    //pnlBotoes.Height := pnlBotoes.Height - btnInfCof.Height;
    //btnSair.Top      := btnConfirma.Top;
  End;

  cdsItens.First;
  pSetFocus(dbgItens);
  dbgItens.SelectedField := cdsItens.FieldByName('ITE_BASIPI');

  cdsItens.Active := False;
  cdsItens.Active := True;
  cdsItensAfterPost(cdsItens);

end;

end.
