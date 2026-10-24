unit untFatRomConferenciaVolumes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Grids, DBGridCitel, DBGrids, BitBtnLockedIncrem, DB, UniClientDataSet, StrUtils,
  Datasnap.DBClient, frxClass, frxExportCSVTestabilidade, Math;

type
  TfrmFatRomConferenciaVolumes = class(TfrmPai)
    pnlTopo: TPanel;
    dbgVolumes: TDBGridCitel;
    Label1: TLabel;
    edtCodBar: TEditFocus;
    btnConfirma: TBitBtnLocked;
    cdsVolumes: TUniClientDataSet;
    cdsVolumesNUMDOC: TStringField;
    cdsVolumesESPDOC: TStringField;
    cdsVolumesCODEMP: TStringField;
    cdsVolumesNUMVOL: TIntegerField;
    dtsVolumes: TDataSource;
    btnConfeVolAut: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfeVolAutClick(Sender: TObject);
  private
    procedure pTentaIncluirNovoVolume(strDocDig, strEspDig, strEmpDig: String; intSeqVol: Integer);
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    intQtdVolumes: Integer;
    blnConfDocsRomNaoEntregues: Boolean;
  end;

var
  frmFatRomConferenciaVolumes: TfrmFatRomConferenciaVolumes;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatRomConferenciaVolumes.btnConfeVolAutClick(Sender: TObject);
begin
  inherited;

  if (not fVerificaAcessoSistema('ROMCAV')) then
  begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  end;

  if (not fPergunta('Deseja realizar a conferência automática dos volumes?')) then
    Exit;

  ModalResult := mrOk;
end;

procedure TfrmFatRomConferenciaVolumes.btnConfirmaClick(Sender: TObject);
  Var
    intVolAtual: Integer;
begin
  inherited;
  For intVolAtual := 1 To intQtdVolumes Do
  Begin
    cdsVolumes.First;
    If Not cdsVolumes.Locate('NUMVOL', intVolAtual, []) Then
    Begin
      pSetFocus(edtCodBar);
      pMensagemOk('Volume ' + IntToStr(intVolAtual) + ' não conferido.');
      Exit;
    End;
  End;

  ModalResult := mrOk;
end;

procedure TfrmFatRomConferenciaVolumes.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodBar);
end;

procedure TfrmFatRomConferenciaVolumes.FormCreate(Sender: TObject);
begin
  inherited;
  edtCodBar.MaxLength := IfThen(fTamDocCadRec = 6, 14, 20);
  edtCodBar.TamCampo  := IfThen(fTamDocCadRec = 6, 14, 20);
  blnConfDocsRomNaoEntregues  := False;
end;

procedure TfrmFatRomConferenciaVolumes.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
  Begin
    Key := 0;
    btnConfirma.Click;
  End;
end;

procedure TfrmFatRomConferenciaVolumes.FormShow(Sender: TObject);
begin
  inherited;
  strNumDoc := LeftStr(strNumDoc, fTamDocCadRec);
  cdsVolumes.CreateDataSet;
  cdsVolumes.IndexFieldNames := 'NUMVOL';
  btnConfeVolAut.Visible := blnConfDocsRomNaoEntregues;
end;

function TfrmFatRomConferenciaVolumes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strDocDig: String;
    strEspDig: String;
    strEmpDig: String;
    intSeqVol: Integer;
begin
  Result := False;
  If Sender = edtCodBar Then
  Begin
    strDocDig := Copy(edtCodBar.Text, 1, fTamDocCadRec);
    strEspDig := fRetornaEspeciePeloCodigo(Copy(edtCodBar.Text, IfThen(fTamDocCadRec = 6, 7, 13), 2));
    strEmpDig := Copy(edtCodBar.Text, IfThen(fTamDocCadRec = 6, 9, 15), 3);
    intSeqVol := StrToIntDef(Copy(edtCodBar.Text, IfThen(fTamDocCadRec = 6, 12, 18), 3), -1);

    pTentaIncluirNovoVolume(strDocDig, strEspDig, strEmpDig, intSeqVol);
    edtCodBar.Clear;
    pSetFocus(edtCodBar);
  End;
end;

procedure TfrmFatRomConferenciaVolumes.pTentaIncluirNovoVolume(strDocDig, strEspDig,
  strEmpDig: String; intSeqVol: Integer);

  function fPedidoConfirmadoNoDocumento: Boolean;
  begin
    Result := False;
    If (strEspDig = 'PD') Then
    Begin
      Result := SameText(Concat(strNumDoc, strEspDoc, strCodEmp),
                         fCampoTabela('CONCAT(FGO_NUMFAT, FGO_TIPFAT, FGO_EMPFAT)',
                                      'FATGOR',
                                      ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                                      [strDocDig, strEspDig, strEmpDig]));
    End;
  end;

begin
  If intSeqVol <= 0 Then
  Begin
    pMensagemOk('Código de barras inválido.');
  End
  Else If ((strDocDig <> strNumDoc) Or
           (strEspDig <> strEspDoc) Or
           (strEmpDig <> strCodEmp)) And (Not fPedidoConfirmadoNoDocumento) Then
  Begin
    pMensagemOk('Código de barras não corresponde ao documento atual.');
  End
  Else If cdsVolumes.Locate('NUMVOL', intSeqVol, []) Then
  Begin
    pMensagemOk('Este volume já foi conferido.');
  End
  Else If intSeqVol > intQtdVolumes Then
  Begin
    pMensagemOk('Número do volume maior que a quantidade de volumes, por favor, verifique.');
  End
  Else
  Begin
    cdsVolumes.Append;
    cdsVolumesNUMDOC.AsString := strDocDig;
    cdsVolumesESPDOC.AsString := strEspDig;
    cdsVolumesCODEMP.AsString := strEmpDig;
    cdsVolumesNUMVOL.AsInteger := intSeqVol;
    cdsVolumes.Post;
  End;
end;

end.
