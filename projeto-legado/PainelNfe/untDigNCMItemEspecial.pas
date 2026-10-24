unit untDigNCMItemEspecial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, DB, Grids, DBGrids,
  EditFocus, MemDS,

  {$IF Defined(VER250) Or Defined(VER270) Or Defined(VER280) Or Defined(VER300)}
    System.UITypes,
  {$IFEND}

  DBClient;

type
  TfrmDigNCMItemEspecial = class(TForm)
    pnlFundo: TPanel;
    pnlBotoes: TPanel;
    btnSair: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    dbgItens: TDBGrid;
    Label2: TLabel;
    dtsItens: TDataSource;
    cdsItens: TClientDataSet;
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgItensKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    const MAX_CODNCM = 8;
    procedure pMensagemOk(strMensagem: String);
    procedure pBuscaNCM;
    function fValidaCodigoNCM(strCodNCM: String): Boolean;
    function fVerificaNCMValido: Boolean;
    function fAlterarNCMItens: Boolean;
    procedure pEditarNCMGrid(strCodNCM: String);
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  untConsulta, untNCMController, untNCMModel;

{$R *.dfm}

procedure TfrmDigNCMItemEspecial.btnConfirmaClick(Sender: TObject);
begin
  if fAlterarNCMItens then
    ModalResult := mrOk;
end;

procedure TfrmDigNCMItemEspecial.pMensagemOk(strMensagem: String);
begin
  MessageDlg(strMensagem, mtInformation, [mbOK], 0);
end;

procedure TfrmDigNCMItemEspecial.pBuscaNCM;
var
  stlSel: TStringList;
  stlCampos: TStringList;
  stlNomesCol: TStringList;
  stlOrder: TStringList;
  frmConsulta: TfrmConsulta;
begin
  Application.CreateForm(TfrmConsulta, frmConsulta);
  stlSel := TStringList.Create;
  stlCampos := TStringList.Create;
  stlOrder := TStringList.Create;
  stlNomesCol := TStringList.Create;

  try
    stlCampos.Add('NCM_CODNCM');
    stlCampos.Add('NCM_DESCRI');

    stlNomesCol.Add('Código');
    stlNomesCol.Add('Descrição');

    stlOrder.Add('NCM_DESCRI');

    frmConsulta.pConsulta(stlSel, stlCampos, stlNomesCol, stlOrder, '', 'CADNCM',
      'Consulta de Nomenclatura Comum do Mercosul (NCM)', Self.Name);

    if (frmConsulta.ShowModal = mrOK) then
      pEditarNCMGrid(stlSel[0]);
  finally
    FreeAndNil(stlSel);
    FreeAndNil(stlCampos);
    FreeAndNil(stlOrder);
    FreeAndNil(stlNomesCol);
  end;
end;

procedure TfrmDigNCMItemEspecial.pEditarNCMGrid(strCodNCM: String);
begin
  cdsItens.Edit;
  cdsItens.FieldByName('DET_NCMITE').AsString := strCodNCM;
  cdsItens.Post;
end;

function TfrmDigNCMItemEspecial.fVerificaNCMValido: Boolean;
begin
  Result := True;

  if cdsItens.FieldByName('DET_NCMITE').AsString = '' then
  begin
    pMensagemOk('Informe o NCM do item');
    Result := False;
  end
  else if (not fValidaCodigoNCM(cdsItens.FieldByName('DET_NCMITE').AsString)) then
  begin
    pMensagemOk('NCM não cadastrado.');
    Result := False;
  end
  else if Length(cdsItens.FieldByName('DET_NCMITE').AsString) <> MAX_CODNCM then
  begin
    pMensagemOk('NCM deve conter ' + IntToStr(MAX_CODNCM) + ' caracteres.');
    Result := False;
  end;

  if not Result then
    dbgItens.SetFocus;
end;

function TfrmDigNCMItemEspecial.fValidaCodigoNCM(strCodNCM: String): Boolean;
begin
  Result :=  TNCMController.get.fRetornaNCM(strCodNCM) <> nil;
end;

procedure TfrmDigNCMItemEspecial.dbgItensKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = '/' then
  begin
    Key := #0;
    pBuscaNCM;
  end;
end;

function TfrmDigNCMItemEspecial.fAlterarNCMItens: Boolean;
var
  stSeqGerMovTri: String;
  strNCM: String;
begin
  Result := False;
  try
    cdsItens.First;
    while not cdsItens.Eof do
    begin
      if not fVerificaNCMValido then
        Exit;

      strNCM := cdsItens.FieldByName('DET_NCMITE').AsString;
      stSeqGerMovTri := cdsItens.FieldByName('AUTOINCREM').AsString;

      if not TNCMController.get.fAtualizaNCMItemEspecial(stSeqGerMovTri, strNCM) then
        Exit;

      cdsItens.Next;
    end;
  except
    on E : Exception do
      MessageDlg(e.Message, mtError,[mbOk],0);
  end;
  Result := True;
end;

procedure TfrmDigNCMItemEspecial.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close;
  end;
end;

end.
