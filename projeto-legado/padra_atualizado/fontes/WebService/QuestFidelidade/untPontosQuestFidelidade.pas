unit untPontosQuestFidelidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Uni, UniClientDataSet;

type
  TfrmPontosQuestFidelidade = class(TfrmPai)
    pnlGeral: TPanel;
    lblNome: TLabel;
    btnConfirmaDados: TBitBtnLocked;
    lblNomeParticipante: TLabel;
    lblPontos: TLabel;
    lblPontosParticipante: TLabel;
    rdgPontos: TRadioGroup;
    edtPontos: TEditFocus;
    lblValor: TLabel;
    lblValorParticipante: TLabel;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure rdgPontosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    strNumDoc: string;
    strItens: string;
    function fUsaQuestFidelidade(strAutInc: string): Boolean;
    function fUsaQuestFidelidadeCDS(strItens: string): Boolean;
    { Public declarations }
  end;


implementation

uses
  untFuncoesSimples,Data.DB;

{$R *.dfm}

{ TfrmPontosQuestFidelidade }

procedure TfrmPontosQuestFidelidade.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  if (fVerificaCampos) then
  begin
    Close;
    ModalResult := mrOk;
  end;
end;

procedure TfrmPontosQuestFidelidade.FormShow(Sender: TObject);
begin
  inherited;
  rdgPontos.ItemIndex := 0;
  //pSetFocus(TRadioGroup(rdgPontos.Controls[0]));
  pSetFocus(btnConfirmaDados);
end;

function TfrmPontosQuestFidelidade.fUsaQuestFidelidade(
  strAutInc: string): Boolean;
var
  qryQuest: TUniQuery;
begin
  try
    Result := False;

    qryQuest := fCriaQuery;
    qryQuest.Close;
    qryQuest.SQL.Clear;
    qryQuest.SQL.Add('SELECT COUNT(*) AS TOTAL');
    qryQuest.SQL.Add('FROM FATDOR F');
    qryQuest.SQL.Add('INNER JOIN CADITE I ON(F.FDO_CODITE = I.ITE_CODITE)');
    qryQuest.SQL.Add('WHERE F.FDO_SEQGER = :AUTINC');
    qryQuest.SQL.Add('AND I.ITE_USAQUE = "S"');
    qryQuest.ParamByName('AUTINC').AsString := strAutInc;
    qryQuest.Open;

    Result := (not qryQuest.IsEmpty) And (qryQuest.FieldByName('TOTAL').AsInteger > 0);

  finally
    FreeAndNil(qryQuest);
  end;
end;

function TfrmPontosQuestFidelidade.fUsaQuestFidelidadeCDS(strItens: string): Boolean;
var
  qryQuest: TUniQuery;
begin
  try
    Result := False;

    qryQuest := fCriaQuery;
    qryQuest.Close;
    qryQuest.SQL.Clear;
    qryQuest.SQL.Add('SELECT COUNT(ITE_USAQUE) AS TOTAL FROM CADITE WHERE ITE_CODITE IN('+strItens+') AND ITE_USAQUE = "S" ');
    qryQuest.Open;

    Result := (not qryQuest.IsEmpty) And (qryQuest.FieldByName('TOTAL').AsInteger > 0);

  finally
    FreeAndNil(qryQuest);
  end;
end;

function TfrmPontosQuestFidelidade.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (Sender = edtPontos) Then
  Begin
    If (rdgPontos.ItemIndex = 2) And (StrToFloatDef(edtPontos.Text,0) <= 0) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO', 'Informe o valor que será utilizado!', ['&Ok']);
      pSetFocus(edtPontos);
    End
    Else If (rdgPontos.ItemIndex = 2) And (StrToFloatDef(edtPontos.Text,0) > StrToFloatDef(lblValorParticipante.Caption,0)) then
    begin
      Result := False;
      fMensagem('ATENÇÃO', 'O valor informado não pode ser maior que o valor disponível!', ['&Ok']);
      pSetFocus(edtPontos);
    end;
  End
end;

procedure TfrmPontosQuestFidelidade.rdgPontosClick(Sender: TObject);
begin
  inherited;
  edtPontos.Enabled := rdgPontos.ItemIndex = 2;
end;

end.
