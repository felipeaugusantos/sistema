unit untDigQtdEti;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Menus, AppEvnts, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxCheckBox, untIteBar, Windows, ComboBoxFocus,
  Uni, BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmDigQtdEti = class(TfrmPaiSimples)
    edtQtdEti: TEditFocus;
    Label1: TLabel;
    pnlFundo: TPanel;
    pnlCodBar: TPanel;
    Panel1: TPanel;
    cxgIteBarView: TcxGridDBTableView;
    cxgIteBarLevel1: TcxGridLevel;
    cxgIteBar: TcxGrid;
    Panel2: TPanel;
    cxgIteBarBAR_CODBAR: TcxGridDBColumn;
    cxgIteBarBAR_EMBALA: TcxGridDBColumn;
    cxgIteBarBAR_PRINCI: TcxGridDBColumn;
    cxgIteBarBAR_COMPRA: TcxGridDBColumn;
    cxgIteBarBAR_DESCRI: TcxGridDBColumn;
    pnlArmazem: TPanel;
    Label2: TLabel;
    cbxArmazem: TComboBoxFocus;
    btnCancela: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    lblMultiSelect: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    objIteBar: TIteBar;
    procedure pCarregaArmazens(strCodIte: String);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetListaCodBarras :TStringList;
  public
    { Public declarations }
    strCodIte: String;
    strCodBar: TStringList;
    intQtdEti: Integer;
    strCodAmz: String;

    blnConfirma: Boolean;

  end;


implementation

uses untfuncoesSimples, untTypesSistema;

{$R *.dfm}

{ TfrmDigQtdEti }

procedure TfrmDigQtdEti.FormShow(Sender: TObject);
begin
  inherited;

  blnConfirma := False;

  pnlArmazem.Visible := (fCfgSis('CTLEST') = '2') And (Not fEmptyStr(strCodIte));

  If fEmptyStr(strCodIte) Then
    Exit;

  objIteBar := TIteBar.Create(opcOperacoes);
  objIteBar.pCarregaDados(strCodIte);

  strCodBar.Clear;

  If (pnlArmazem.Visible) And (Not fEmptyStr(strCodIte)) Then
    pCarregaArmazens(strCodIte);

  If objIteBar.cdsIteBar.RecordCount > 1 Then
  Begin
    objIteBar.cdsIteBar.Locate('BAR_PRINCI', 1, []);
    cxgIteBarView.DataController.DataSource := objIteBar.dtsIteBar;
    pnlCodBar.Visible := True;
    Self.Height := Self.Height + pnlCodBar.Height + 5;
  End;

  If Not fCfgSis('PRVEMB', VarBoolean) Then
  Begin
    cxgIteBarBAR_DESCRI.Visible := False;
    Self.Width := Self.Width - cxgIteBarBAR_DESCRI.Width;
  End;

end;

function TfrmDigQtdEti.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA A QUANTIDADE DE ETIQUETAS      *}
    {**************************************MV*}
    If (Sender = edtQtdEti) Then
    Begin
      If fEmptyStr(edtQtdEti.Text) Then
      Begin
        fMensagem('', 'A quantidade de etiquetas deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If StrToInt(edtQtdEti.Text) < 0 Then
      Begin
        fMensagem('', 'A quantidade de etiquetas deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        intQtdEti := StrToInt(edtQtdEti.Text);

        If pnlArmazem.Visible Then
          strCodAmz := Copy(cbxArmazem.Items.Strings[cbxArmazem.ItemIndex], 1, 3);

        If Not pnlCodBar.Visible Then
        Begin
          blnConfirma := True;
          Close;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmDigQtdEti.pCarregaArmazens(strCodIte: String);
  Var
    qryTmp : TUniQuery;
begin
  cbxArmazem.Items.Clear;

  qryTmp := fCriaQuery(Self);
  qryTmp.SQL.Add('    SELECT LOT_NUMLOT, AMZ_DESCRI ');
  qryTmp.SQL.Add('      FROM CADLOT ');
  qryTmp.SQL.Add(' LEFT JOIN CADAMZ ON AMZ_CODAMZ = LOT_NUMLOT AND AMZ_CODEMP = LOT_CODEMP ');
  qryTmp.SQL.Add('     WHERE LOT_CODITE = :CODITE ');
  qryTmp.SQL.Add('       AND LOT_CODEMP = :CODEMP ');
  qryTmp.SQL.Add('       AND LENGTH(LOT_NUMLOT) = 3 ');
  qryTmp.ParamByName('CODITE').AsString := strCodIte;
  qryTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryTmp.Open;

  If qryTmp.RecordCount > 0 Then
  Begin
    qryTmp.First;
    While Not qryTmp.Eof Do
    Begin
      cbxArmazem.Items.Add(qryTmp.FieldByName('LOT_NUMLOT').AsString + ' - ' + qryTmp.FieldByName('AMZ_DESCRI').AsString);
      qryTmp.Next;
    End;

    If qryTmp.RecordCount >= 1 Then
      cbxArmazem.ItemIndex := 0;

  End
  Else Begin
    pnlArmazem.Visible := False;
    Self.Height := Self.Height - pnlArmazem.Height;
  End;

  qryTmp.Close;
  FreeAndNil(qryTmp);
end;

procedure TfrmDigQtdEti.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    strCodBar := fGetListaCodBarras;
    //strCodBar := objIteBar.cdsIteBar.FieldByName('BAR_CODBAR').AsString;
    If pnlArmazem.Visible Then
    Begin
      strCodAmz := Copy(cbxArmazem.Items.Strings[cbxArmazem.ItemIndex], 1, 3);
    End;

    blnConfirma := True;

    Close;
  End;
end;

procedure TfrmDigQtdEti.btnSairClick(Sender: TObject);
begin
  inherited;

  intQtdEti := 0;
  strCodAmz := '';
end;

function TfrmDigQtdEti.fGetListaCodBarras: TStringList;
var
  stlCodBarras :TStringList;
  i :Integer;
begin
  stlCodBarras := TStringList.Create;

  with cxgIteBarView do
  begin
    DataController.BeginLocate;
    DataController.DataSet.DisableControls;

    if Controller.SelectedRowCount > 0 then
    begin
      for i:=0 to Controller.SelectedRowCount - 1 do
      begin
        stlCodBarras.Add(Controller.SelectedRows[i].Values[GetColumnByFieldName('BAR_CODBAR').Index]);
      end;
      intQtdEti := StrToInt(edtQtdEti.Text) * cxgIteBarView.Controller.SelectedRowCount;

    end
    //Se não tiver código de barras selecionado seleciona o principal
    Else
    Begin
      cxgIteBarView.DataController.DataSet.First;
      While (Not (cxgIteBarView.DataController.DataSet.FieldByName('BAR_PRINCI').AsInteger = 1)) And
            (Not (cxgIteBarView.DataController.DataSet.EoF)) Do
      Begin
        cxgIteBarView.DataController.DataSet.Next;
      End;
      stlCodBarras.Add(cxgIteBarView.DataController.DataSet.FieldByName('BAR_CODBAR').AsString);
      intQtdEti := StrToInt(edtQtdEti.Text);
    End;


    DataController.EndLocate;
    DataController.DataSet.EnableControls;
       
  end;

  Result := stlCodBarras;
end;

procedure TfrmDigQtdEti.FormCreate(Sender: TObject);
begin
  inherited;

  If (Not pnlArmazem.Visible) Then
    Self.Height := Self.Height - pnlArmazem.Height;

  intQtdEti := 0;
  edtQtdEti.SelectAll;

  strCodBar := TStringList.Create;
  strCodBar.Clear;
//  strCodBar := '';
  objIteBar := Nil;
  
  pnlCodBar.Visible := False;
  Self.Height := Self.Height - pnlCodBar.Height;
end;

procedure TfrmDigQtdEti.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: If pnlCodBar.Visible Then
            Begin
              Key := 0;
              btnConfirma.Click;
            End;
  End;
end;

end.

