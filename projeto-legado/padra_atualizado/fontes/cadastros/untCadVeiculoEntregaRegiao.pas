unit untCadVeiculoEntregaRegiao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem, Uni,
  ExtCtrls, Mask, MaskEditFocus, EditFocus, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadVeiculoEntregaRegiao = class(TfrmPai)
    pnlGeral    : TPanel;
    Label1      : TLabel;
    btnConfirmar: TBitBtnLocked;
    mskPlaVei   : TMaskEditFocus;
    edtDesVei   : TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    strFiltro: String;
    strVeiculos: String;
    procedure pLimpaTela;

    function fGravaVeiculoRota: Boolean;
    function fRetFiltroVeiculosRota: String;
    function fRetornaDescricaoVeiculo(strPlaVei: String): String;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodRot  : String;
    blnConfirma: Boolean;
  end;

var
  frmCadVeiculoEntregaRegiao: TfrmCadVeiculoEntregaRegiao;

implementation
uses
    untConsultas, untFuncoesSimples, untTypesSistema;

{$R *.dfm}

procedure TfrmCadVeiculoEntregaRegiao.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
    blnConfirma := fGravaVeiculoRota;

  If blnConfirma Then
    Self.Close;
end;

procedure TfrmCadVeiculoEntregaRegiao.btnSairClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

function TfrmCadVeiculoEntregaRegiao.fRetFiltroVeiculosRota: String;
var
  qryCons: TUniQuery;
begin
  Result := '';
  Try
    qryCons := fCriaQuery(Nil);

    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT REV_PLAVEI ');
      SQL.Add(' FROM ROTREV ');
      SQL.Add(' WHERE REV_CODREG = :CODREG ');
      SQL.Add('   AND REV_CODEMP = :CODEMP ');
      ParamByName('CODREG').AsString := fRetCodigoRegiaoRota(strCodRot);
      ParamByName('CODEMP').AsString := fRetEmpresaRotaRegiao(ParamByName('CODREG').AsString);
      Open;

      If Not IsEmpty Then
      Begin
        First;
        While Not Eof Do
        Begin
          Result := Result + QuotedStr(FieldByName('REV_PLAVEI').AsString) + ',';
          Next;
        End;

        Result := Copy(Result, 0, Length(Result)-1);
      End;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

function TfrmCadVeiculoEntregaRegiao.fGravaVeiculoRota: Boolean;
  function fRetSQL: String;
  Begin
    Result := '';
    Result := Result + ' UPDATE ENTREG ';
    Result := Result + '   SET ENT_ROTVEI = :ROTVEI ';
    Result := Result + ' WHERE ENT_CODIGO = :CODROT ';
  End;
var
  qryIns   : TUniQuery;
  strCodReg: String;
begin
  Result := True;
  Try
    qryIns := fCriaQuery(Nil);
    Try
      strCodReg := fRetCodigoRegiaoRota(strCodRot);

      With qryIns Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetSQL);
        ParamByName('ROTVEI').AsString := fRetVeiculoRotasRegiao(strCodReg, mskPlaVei.Text);
        ParamByName('CODROT').AsString := strCodRot;
        ExecSql;
      End;

      fMensagem('INFORMAÇÃO','Veículo alterado com sucesso !', ['&Ok']);
      pLimpaTela;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fGravaVeiculoRota]');
      End;
    End;
  Finally
    FreeAndNil(qryIns);
  End;
end;

procedure TfrmCadVeiculoEntregaRegiao.FormCreate(Sender: TObject);
begin
  inherited;
  strFiltro := '';
  strVeiculos := '';
end;

procedure TfrmCadVeiculoEntregaRegiao.FormShow(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  strVeiculos := fRetFiltroVeiculosRota;
  pSetFocus(mskPlaVei);

  If Not fEmptyStr(strVeiculos) Then
    strFiltro := ' VEI_PLAVEI IN (' + strVeiculos + ')' + ' AND VEI_STATUS = "A" '
  Else
    strFiltro := ' FALSE ';
end;

function TfrmCadVeiculoEntregaRegiao.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = mskPlaVei) Then
    Begin

      If fVeiculoInativo(fTiraCaracEspeciais(mskPlaVei.Text)) Then
      Begin
        edtDesVei.Text := '';
        fMensagem('','Este veículo está inativo.',['&O k']);
        Result := False;
      End
      Else
      Begin
        If Not fEmptyStr(mskPlaVei.Text) Then
        Begin
          edtDesVei.Text := fRetornaDescricaoVeiculo(mskPlaVei.Text);
          If fEmptyStr(edtDesVei.Text)  Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse veículo não está cadastrado na região selecionada!', ['&Ok']);
            Result := False;
          End;
        End
        Else
        Begin
          edtDesVei.Clear;
          fMensagem('ATENÇÃO!', 'O veículo deve ser informado!', ['&Ok']);
          Result := False;
        End;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadVeiculoEntregaRegiao.mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
Var
  arrVei: TConsultasArray;
begin
  inherited;

  If fPesqVeiculos(Self, mskPlaVei, edtDesVei, Nil, Key, arrVei, True, False, strFiltro) Then
  Begin
    If fValidaCampos(mskPlaVei, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadVeiculoEntregaRegiao.pLimpaTela;
begin
  mskPlaVei.Clear;
  edtDesVei.Clear;
end;

function TfrmCadVeiculoEntregaRegiao.fRetornaDescricaoVeiculo(strPlaVei: String): String;
var
  qryCons: TUniQuery;
begin
  Result := '';
  Try
    qryCons := fCriaQuery(Nil);

    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT ');
      SQL.Add(' CONCAT(IFNULL(MAR_DESMAR, ""), " ", ');
      SQL.Add('        IFNULL(MOD_DESMOD, ""), " ", ');
      SQL.Add('        IFNULL(VEI_ANOVEI, ""), " ", ');
      SQL.Add('        IFNULL(COR_DESCOR, ""), " ") AS DESCRI ');
      SQL.Add(' FROM CADVEI ');
      SQL.Add('   LEFT JOIN CORVEI ON VEI_CODCOR = COR_CODCOR ');
      SQL.Add('   LEFT JOIN MARVEI ON VEI_CODMAR = MAR_CODMAR ');
      SQL.Add('   LEFT JOIN MODVEI ON VEI_CODMOD = MOD_CODMOD ');
      SQL.Add(' WHERE VEI_PLAVEI = :PLAVEI ');

      If Not fEmptyStr(strVeiculos) Then
        SQL.Add(' AND VEI_PLAVEI IN (' + strVeiculos + ')')
      Else
        SQL.Add(' AND FALSE ');

      ParamByName('PLAVEI').AsString := strPlaVei;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('DESCRI').AsString
      Else
        Result := '';
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

end.
