unit untEmpresas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, CheckLst, AppEvnts, Buttons, ExtCtrls, Uni,
  StrUtils, Vcl.Grids, frxClass, frxExportCSVTestabilidade, Vcl.Menus,
  BitBtnLockedIncrem;

type
  TfrmEmpresas = class(TfrmPai)
    btnConfirma: TBitBtn;
    btnSairNovo: TSpeedButton;
    pnlPrincipal: TPanel;
    lstEmpresas: TCheckListBox;
    Panel1: TPanel;
    Shape1: TShape;
    Label2: TLabel;
    btnConfirmaNovo: TSpeedButton;
    Label1: TLabel;
    Panel3: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure lstEmpresasClickCheck(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
    procedure pnlBotoesResize(Sender: TObject);
    procedure pCarregaListaEmpresas;
    
  private
    { Private declarations }
    qryEmpresas: TUniQuery;
  public
    { Public declarations }
    strEmpAtu: String;
    strEmpresaSelecionada: string;

  end;

var
  frmEmpresas: TfrmEmpresas;

implementation

uses untFuncoes;

{$R *.dfm}

procedure TfrmEmpresas.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaListaEmpresas;
end;

procedure TfrmEmpresas.pCarregaListaEmpresas;
  Var
    intContador: Integer;
begin

  qryEmpresas := TUniQuery.Create(Self);
  qryEmpresas.Connection := fRetConexao;
  qryEmpresas.SQL.Add(' SELECT EMP_CODEMP, ');
  qryEmpresas.SQL.Add('        EMP_NOMEMP, ');
  qryEmpresas.SQL.Add('        EMP_CODCTB ');
  qryEmpresas.SQL.Add('   FROM CADEMP ');
  qryEmpresas.SQL.Add('  ORDER BY EMP_CODEMP ');
  lstEmpresas.Clear;

  qryEmpresas.Open;
  qryEmpresas.First;
  While (Not qryEmpresas.Eof) Do
  begin
    lstEmpresas.Items.Add(qryEmpresas.FieldByName('EMP_CODEMP').AsString + '-' +
                          qryEmpresas.FieldByName('EMP_NOMEMP').AsString);

    qryEmpresas.Next;
  end;
  qryEmpresas.Close;

  For intContador := 0 To lstEmpresas.Count -1 Do
  begin
    if LeftStr(lstEmpresas.Items[intContador], 3) = strEmpAtu then
    begin
      lstEmpresas.Checked[intContador] := True;
      Break;
    end;
  end;

  lstEmpresas.ItemIndex := 0;
end;

procedure TfrmEmpresas.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(VS_strCodEmp)) Then
    Exit;

  pValidaProCod('CADRDZ');
  pValidaProCod('RDZTOT');
  pValidaProCod('CADGNR');
  pValidaProCod('MOVICM');
  VS_strClaCom := fTransform(fCfgSis('CLACOM'), 4);
  VS_strClaVen := fTransform(fCfgSis('CLAVEN'), 4);
  VS_strClaDev := fTransform(fCfgSis('CLADEV'), 4);

  pAtuVarGlobais;

  ModalResult := mrOk;
end;

procedure TfrmEmpresas.lstEmpresasClickCheck(Sender: TObject);
  Var
    intContador, intItemSelected: Integer;
    strNovEmp: String;
begin
  inherited;
  strNovEmp := '';
  intContador := 0;
  intItemSelected := 0;
  While intContador < lstEmpresas.Count Do
  begin
    if (lstEmpresas.Checked[intContador]) then
    begin
      if LeftStr(lstEmpresas.Items[intContador], 3) = strEmpAtu then
        lstEmpresas.Checked[intContador] := False
      else
      begin
        strNovEmp := LeftStr(lstEmpresas.Items[intContador], 3);

        intItemSelected := intContador;

        strEmpAtu := strNovEmp;
        VS_strCodEmp := strEmpAtu;
        Break;
      end;
    end;
    intContador := intContador + 1;
  end;

  For intContador := 0 To lstEmpresas.Count -1 Do
  begin
    if (lstEmpresas.Checked[intContador]) then
    begin
      lstEmpresas.Checked[intContador] := False;
    end;
  end;

  lstEmpresas.Checked[intItemSelected] := True;
end;

procedure TfrmEmpresas.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  inherited;
  if Msg.message = WM_KEYFIRST then
  begin
    if Msg.wParam = 13 then
      btnConfirma.Click;
    if Msg.wParam = 27 then
      btnSair.Click;
  end;
end;

procedure TfrmEmpresas.pnlBotoesResize(Sender: TObject);
begin
  btnConfirmaNovo.Left := 2;
  btnConfirmaNovo.Top := 1;
  btnSair.Left := pnlBotoes.Width-btnSair.Width;
  btnSair.Top := 1;
end;

end.
