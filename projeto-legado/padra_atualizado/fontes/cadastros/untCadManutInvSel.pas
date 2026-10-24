unit untCadManutInvSel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, CheckLst,
  StrUtils, AppEvnts, Uni, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadManutInvSel = class(TfrmPai)
    btnAlterar: TBitBtnLocked;
    pnlTipInv: TPanel;
    rdgTipoArq: TRadioGroup;
    Panel1: TPanel;
    Label4: TLabel;
    lstArquivos: TCheckListBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure lstArquivosClickCheck(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rdgTipoArqClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    stlArqInv: TStringList;
    procedure pCarregaTabelas(strPrefixo: String);
  public
    { Public declarations }
    strPrefixoTab,
    strNomTab,
    strAnoTab: String;
  end;

var
  frmCadManutInvSel: TfrmCadManutInvSel;

implementation

uses untfuncoesSimples, DB, untTypesSistema, untConstantes;

{$R *.dfm}

procedure TfrmCadManutInvSel.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE : Close;
    VK_RETURN : If ActiveControl Is TRadioButton Then
                  SelectNext(ActiveControl,True,True);
    VK_F10    : Begin
                  Key := 0;
                  btnAlterar.Click;
                End;
  End;
end;

procedure TfrmCadManutInvSel.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaTabelas(strPrefixoTab + '\_');
end;

procedure TfrmCadManutInvSel.lstArquivosClickCheck(Sender: TObject);
  Var
    intContador: Integer;
begin
  inherited;

  For intContador := 0 To lstArquivos.Items.Count -1 Do
  Begin

    If intContador <> lstArquivos.ItemIndex Then
    Begin
      lstArquivos.Checked[intContador] := False;
    End;

  End;

end;

procedure TfrmCadManutInvSel.FormCreate(Sender: TObject);
begin
  inherited;
  strNomTab := '';
  strPrefixoTab := 'I';
  stlArqInv := TStringList.Create;
end;

procedure TfrmCadManutInvSel.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(stlArqInv);
end;

procedure TfrmCadManutInvSel.FormClose(Sender: TObject;
  var Action: TCloseAction);
  Var
    intIndex: Integer;
    blnSel  : Boolean;
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    blnSel := False;
    For intIndex := 0 to lstArquivos.Count - 1 Do
      If lstArquivos.Checked[intIndex] Then
      Begin
        strNomTab := stlArqInv[intIndex];
        strAnoTab := lstArquivos.Items[intIndex];
        blnSel    := True;
      End;

    If Not blnSel Then
    Begin
      fMensagem('', 'Selecione um arquivo para alteração.',['&OK']);
      Action := caNone;
      Exit;
    End;

  End;

end;

procedure TfrmCadManutInvSel.rdgTipoArqClick(Sender: TObject);
begin
  inherited;
  If (rdgTipoArq.ItemIndex = 0) Then
    pCarregaTabelas(strPrefixoTab + '\_')
  Else
    pCarregaTabelas('SALINV');
end;

procedure TfrmCadManutInvSel.pCarregaTabelas(strPrefixo: String);
  Var
    qryGen: TUniQuery;
    strNome: String;
    intMes: Integer;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Add('SHOW TABLES ');
  qryGen.SQL.Add('  LIKE ' + QuotedStr(strPrefixo + '%'));
  qryGen.Open;

  lstArquivos.Clear;
  stlArqInv.Clear;
  While Not qryGen.Eof Do
  Begin
    strNome := qryGen.Fields[0].AsString;
    stlArqInv.Add(strNome);

    intMes := strToIntDef(Copy(strNome,7,2), 0);

    If AnsiStartsText(strPrefixoTab+ '_', strNome) And (intMes In [1..12]) Then
      lstArquivos.Items.Add(String(arrMesAbr[intMes]) + '/' + copy(strNome,3,4) + copy(strNome,9,(Length(strNome)-8)))
    Else
      lstArquivos.Items.Add(strNome);

    qryGen.Next;
  End;
end;

end.

