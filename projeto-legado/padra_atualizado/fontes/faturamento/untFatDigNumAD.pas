unit untFatDigNumAD;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, Uni,
  ExtCtrls, Mask, MaskEditFocus, AppEvnts, EditFocus, StrUtils,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, QColorLabel, Data.Db;

type
  TfrmFatDigNumAD = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlNumDoc: TPanel;
    lblNumAD: TLabel;
    edtNumAD: TEditFocus;
    procedure btnCancelaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtNumADKeyPress(Sender: TObject; var Key: Char);
  private
    procedure pCarregarDadosAD(strCodAde: string);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    strCodCli: String;
    qryItens : TUniQuery;
  end;

var
  frmFatDigNumAD: TfrmFatDigNumAD;

implementation

uses untfuncoesSimples, untConsultas, untTypesSistema, untFatVendas,
  untFuncoesCRM, untConstantes, untPesqAux;

{$R *.dfm}

procedure TfrmFatDigNumAD.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

function TfrmFatDigNumAD.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Var
  strDocDev: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumAD) Then
    Begin
      If fEmptyStr(edtNumAD.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário informar o número do AD!', ['&O k']);
        Result := False;
      End
      Else If Not fNumADCadastrado(edtNumAD.Text, strCodCli, VS_strCodEmp) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não existe este AD para este cliente!', ['&O k']);
        Result := False;
      End
      Else If fTemDevolucaoRealizadaParaAD(edtNumAD.Text, VS_strCodEmp, strDocDev) Then
      Begin
        fMensagem('ATENÇÃO!', 'Já foi realizada uma devolução com o documento ' + strDocDev + ' ' +
                              'para esta AD!', ['&O k']);
        Result := False;
      End
      Else If (fCampoTabela('COUNT(0)', 'ADEDET', ['DET_CODADE', 'DET_GARANT'], [edtNumAD.Text, 'N']) = 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Só é Permitido AD Referente a Devolução!', ['&O k']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmFatDigNumAD.pCarregarDadosAD(strCodAde: string);
Var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT OCO_CODCLI ');
    qryAux.SQL.Add('FROM ADEGER      ');
    qryAux.SQL.Add('  INNER JOIN MOVOCO ON GER_CODEMP = OCO_CODEMP AND GER_CODOCO = OCO_CODOCO ');
    qryAux.SQL.Add('WHERE             ');
    qryAux.SQL.Add('  GER_CODADE = :CODADE ');
    qryAux.SQL.Add('  AND GER_CODEMP = :CODEMP ');

    qryAux.ParamByName('CODADE').AsString := strCodAde;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.Open;

    If Not qryAux.IsEmpty Then
    Begin
      strCodCli := qryAux.FieldByName('OCO_CODCLI').AsString;
    end;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmFatDigNumAD.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma  := False;
end;

procedure TfrmFatDigNumAD.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin

    pCarregarDadosAD(edtNumAD.Text);

    Self.Close;
    blnConfirma := True;
  End;
end;

procedure TfrmFatDigNumAD.edtNumADKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqAD(Self, edtNumAD, Nil, Key, strCodCli, True, 'N') Then
  Begin
    If fValidaCampos(edtNumAD) Then
      SelectNext(edtNumAD, True, True);
  End;
end;

End.


