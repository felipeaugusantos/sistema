unit untCadNovaEntregaRegiao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem, Uni,
  ExtCtrls, Mask, MaskEditFocus, EditFocus, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadNovaEntregaRegiao = class(TfrmPai)
    pnlGeral: TPanel;
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label1: TLabel;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    procedure pLimpaTela;

    function fGravaNovaEntrega: Boolean;
    function fChaveDuplicada: Boolean;
    function fValidaFeriado: Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
  end;


implementation
uses
    untConsultas, untFuncoesSimples, untTypesSistema, RotasPorRegiao.Funcoes;

{$R *.dfm}

procedure TfrmCadNovaEntregaRegiao.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  If (Not fChaveDuplicada) Then
  Begin
    If (fValidaFeriado) And (fVerificaCampos) Then
      blnConfirma := fGravaNovaEntrega;
  End
  Else
    fMensagem('ATENÇÃO','Essa região já existem para essa data de entrega!',['&Ok']);
    
  If blnConfirma Then
    Self.Close;
end;

procedure TfrmCadNovaEntregaRegiao.btnSairClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmCadNovaEntregaRegiao.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrRegiao : TConsultasArray;
begin
  inherited;
  If fPesqRotasRegiao(Self, edtCodReg, Nil, Nil, Key, arrRegiao) Then
		fValidaCampos(edtCodReg, False);
end;

function TfrmCadNovaEntregaRegiao.fChaveDuplicada: Boolean;
var
  qryCons: TUniQuery;
begin

  Try
    qryCons := fCriaQuery(Nil);
    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT COUNT(*) AS QTDE ');
      SQL.Add('   FROM ENTREG ');
      SQL.Add('  WHERE ENT_CODREG = :CODREG ');
      SQL.Add('    AND ENT_DTAENT = :DTAENT ');
      ParamByName('CODREG').AsString := edtCodReg.Text;
      ParamByName('DTAENT').AsDate   := StrToDate(mskDtaIni.Text);            
      Open;

      Result := FieldByName('QTDE').AsInteger > 0;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

function TfrmCadNovaEntregaRegiao.fGravaNovaEntrega: Boolean;
  function fRetSQL: String;
  Begin
    Result := '';
    Result := Result + ' INSERT INTO ENTREG ( ';
    Result := Result + '        ENT_CODIGO,   ';
    Result := Result + '        ENT_CODEMP,   ';
    Result := Result + '        ENT_DTAENT,   ';
    Result := Result + '        ENT_CODREG,   ';
    Result := Result + '        ENT_ROTVEI,   ';
    Result := Result + '        ENT_STATUS,   ';
    Result := Result + '        AUTOINCREM  ) ';
    Result := Result + '            VALUES  ( ';
    Result := Result + '           :CODIGO,   ';
    Result := Result + '           :CODEMP,   ';
    Result := Result + '           :DTAENT,   ';
    Result := Result + '           :CODREG,   ';
    Result := Result + '           :ROTVEI,   ';
    Result := Result + '           :STATUS,   ';
    Result := Result + '           :AUTOIN  ) ';
  End;
var
  qryIns: TUniQuery;
begin
  Result := True;
  Try
    qryIns := fCriaQuery(Nil);
    Try
      With qryIns Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetSQL);
        ParamByName('CODIGO').AsString := fAtualizaProCod('ENTREG', 'ENT_CODIGO');
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('DTAENT').AsDate   := StrToDate(mskDtaIni.Text);
        ParamByName('CODREG').AsString := edtCodReg.Text;
        ParamByName('ROTVEI').AsString := fRetVeiculoPadraoRotasRegiao(edtCodReg.Text);
        ParamByName('STATUS').AsString := 'A'; // ABERTO
        ParamByName('AUTOIN').AsString := fRetAutoIncrem('ENTREG', VS_strCodEmp);
        ExecSql;
      End;
      fMensagem('INFORMAÇÃO','Nova entrega cadastrada com sucesso !', ['&Ok']);
      pLimpaTela;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fGravaNovaEntrega]');
      End;
    End;
  Finally
    FreeAndNil(qryIns);
  End;
end;

procedure TfrmCadNovaEntregaRegiao.FormShow(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date); 
  pSetFocus(mskDtaIni);
end;

function TfrmCadNovaEntregaRegiao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  
  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin
      If ((fEmptyStr(mskDtaIni.Text)) OR (mskDtaIni.Text = '  /  /    ')) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If StrToDate(mskDtaIni.Text) < VS_Date Then
      Begin
        fMensagem('ATENÇÃO!', 'A data de entrega deve ser maior ou igual a hoje !', ['&O k']);
        Result := False;
      End
    End
    
    Else If (Sender = edtCodReg) Then
    Begin
      If (fEmptyStr(edtCodReg.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Região precisa ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtDesReg.Text := fRetNomRotasRegiao(edtCodReg.Text);
        If (fEmptyStr(edtDesReg.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa região não está cadastrada no cadastro de rotas!', ['&Ok']);
          Result := False;
        End;
      End;
    End;
    
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadNovaEntregaRegiao.pLimpaTela;
begin
  mskDtaIni.Clear;
  edtCodReg.Clear;
  edtDesReg.Clear;
end;

function TfrmCadNovaEntregaRegiao.fValidaFeriado: Boolean;
begin
  Result := TFuncoesRotas.fValidaFeriadoCidades(edtCodReg.Text, StrToDateTimeDef(mskDtaIni.Text, 0));
end;

end.
