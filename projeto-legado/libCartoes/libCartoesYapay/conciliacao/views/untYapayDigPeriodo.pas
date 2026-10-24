unit untYapayDigPeriodo;

interface

uses
  System.SysUtils, System.Types, System.Classes, System.Variants,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.AppEvnts, System.StrUtils,

  Uni, EditFocus, MaskEditFocus, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  BitBtnLockedIncrem, cxCheckBox,

  untLibCartoesPaiSimples,  untTLockLibCartoes, untLibCartoesInterfacesTipos,
  untILibCartoesFactory;

type
  TfrmYapayDigPeriodo = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlFundoConcil: TPanel;
    lblDataFinal: TLabel;
    lblDataInicial: TLabel;
    mskDtaFinConcil: TcxDateEdit;
    mskDtaIniConcil: TcxDateEdit;
    lblPeriodoConciliacao: TLabel;
    lblIDConciliacao: TLabel;
    edtIDConciliacao: TEditFocus;
    procedure btnCancelaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtIDConciliacaoKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FTravaPorEstabelecimento: Boolean;
    FobjLockEstabelecimento: TLock;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    objConcil  : TCamposConcil;
    arrPonVen  : TConsultasArray;
    arrEmpresa : TConsultasArray;
    arrCodigoConciliacao  : TConsultasArray;
    strEmpresas: String;
    strPonVen  : String;
    property objLockEstabelecimento : TLock read FobjLockEstabelecimento Write FobjLockEstabelecimento;
  end;


implementation

uses  untTYapayFuncoes;

{$R *.dfm}

procedure TfrmYapayDigPeriodo.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

function TfrmYapayDigPeriodo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = mskDtaIniConcil) Then
    Begin

      If (TYapayFuncoes.fEmptyStr(TYapayFuncoes.fTiraCaracEspeciais(mskDtaIniConcil.Text))) Then
      Begin
        TYapayFuncoes.fMensagem('ATENÇÃO!', 'A Data inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End
    Else If (Sender = mskDtaFinConcil) Then
    Begin

      If TYapayFuncoes.fEmptyStr(TYapayFuncoes.fTiraCaracEspeciais(mskDtaFinConcil.Text)) Then
      Begin
        TYapayFuncoes.fMensagem('ATENÇÃO!', 'A Data final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (Not TYapayFuncoes.fEmptyStr(TYapayFuncoes.fTiraCaracEspeciais(mskDtaFinConcil.Text))) And
              (    TYapayFuncoes.fEmptyStr(TYapayFuncoes.fTiraCaracEspeciais(mskDtaIniConcil.Text))) Then
      Begin
        TYapayFuncoes.fMensagem('ATENÇÃO!', 'Caso informe um período digite primeiramente a data inicial!', ['&O k']);
        Result := False;
      End
      Else If (Not TYapayFuncoes.fEmptyStr(TYapayFuncoes.fTiraCaracEspeciais(mskDtaFinConcil.Text))) And
              (Not TYapayFuncoes.fEmptyStr(TYapayFuncoes.fTiraCaracEspeciais(mskDtaIniConcil.Text))) Then
      Begin
        If (Not TYapayFuncoes.fValidaPeriodo(mskDtaIniConcil.Text, mskDtaFinConcil.Text)) Then
        Begin
          TYapayFuncoes.fMensagem('ATENÇÃO!', 'A data final deve ser maior ou igual a data inicial!', ['&O k']);
          Result := False;
        End;
      End;
    End
    else if (Sender =edtIDConciliacao) then
    begin
      if (Trim(edtIDConciliacao.Text) <> '') and (Length(arrCodigoConciliacao) = 0) then
      begin
        SetLength(arrCodigoConciliacao, 1);
        arrCodigoConciliacao[0].strCodigo := Trim(edtIDConciliacao.Text);
      end;
    end;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;


procedure TfrmYapayDigPeriodo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  TYapayFuncoes.FreeAndNilDatasets(qryTabela);
  inherited;
end;

procedure TfrmYapayDigPeriodo.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;

  FobjLockEstabelecimento := TLock.Create;
end;

procedure TfrmYapayDigPeriodo.FormDestroy(Sender: TObject);
begin
  If Assigned(FobjLockEstabelecimento) Then
    FreeAndNil(FobjLockEstabelecimento);
  inherited;
end;

procedure TfrmYapayDigPeriodo.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Self.Close;
  End;
end;

procedure TfrmYapayDigPeriodo.edtIDConciliacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* CONSULTA DE PONTOS DE VENDA *}
  {****************************AJ*}

  If TLibCartoesFactory.Get.fIPesqArquivosYapay(Self, edtIDConciliacao , Nil, Nil, Key, arrCodigoConciliacao, objConcil, False) Then
  Begin
    If fValidaCampos(edtIDConciliacao) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmYapayDigPeriodo.FormShow(Sender: TObject);
Var
  qryEmpPV: TUniQuery;
  strSQL  : String;
begin
  inherited;
  FTravaPorEstabelecimento :=  False;

  pnlFundoConcil.Visible := True;
  pSetFocus(mskDtaIniConcil);
  mskDtaIniConcil.Date := TLibCartoesFactory.Get.fIGetVS_Date;
  mskDtaFinConcil.Date := TLibCartoesFactory.Get.fIGetVS_Date;

  qryEmpPV := Nil;
  Try
    qryEmpPV := VS_FuncoesExternas.fICriaQuery;
    strSQL := 'SELECT CAR_CODEST FROM ' +
              ' ESTCAR WHERE CAR_NOMOPE="' + objConcil.NomeConciliacao + '"';

    qryEmpPV.SQL.Text := strSQL;
    qryEmpPV.Open;

    strPonVen := '';
    While Not qryEmpPV.Eof Do
    Begin
      strPonVen := strPonVen + qryEmpPV.FieldByName('CAR_CODEST').AsString + '_';
      qryEmpPV.Next;
    End;

  Finally
    TYapayFuncoes.FreeAndNilDatasets(qryEmpPV);
  End;

  Self.Caption := Self.Caption + ' (' + objConcil.NomeConciliacao + ')';
  qryTabela := VS_FuncoesExternas.fICriaQuery;

end;

End.

