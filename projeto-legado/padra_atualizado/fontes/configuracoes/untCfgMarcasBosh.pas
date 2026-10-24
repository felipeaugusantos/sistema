unit untCfgMarcasBosh;

interface

uses
  Windows, Classes, Controls, untPaiOrdena, UniDataSetProvider, Uni, AppEvnts,
  Menus, StdCtrls, EditFocus, MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  BitBtnLockedIncrem, MemDS, DBAccess, Provider, DB, UniClientDataSet, Mask;

type
  TfrmCfgMarcasBosh = class(TfrmPaiOrdena)
    Label3: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    btnExcluir: TBitBtnLocked;
    btnIncluir: TBitBtnLocked;
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure pIncluiMarca;
    procedure pExcluiMarca(strCodMar: String);
    Function fExisteMarca: Boolean;
  public
    { Public declarations }
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  end;

implementation

uses SysUtils, Forms, untPai, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCfgMarcasBosh.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
 Var
   arrLinhaMarca : TConsultasArray;
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrLinhaMarca) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      pSetFocus(btnIncluir);
  End;
end;

function TfrmCfgMarcasBosh.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodMar) Then
    Begin
      If fEmptyStr(edtCodMar.Text) Then
      Begin
        edtDesMar.Clear;
        Result := False;

      End
      Else
      Begin
        edtDesMar.Text := fRetNomMarca(edtCodMar.Text);

        If fEmptyStr(edtDesMar.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Marca não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End;
    End


  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Function TfrmCfgMarcasBosh.fExisteMarca: Boolean;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Clear;

    Add('SELECT * FROM BOSMAR');
    Add('WHERE BOS_CODMAR = :CODMAR');
    ParamByName('CODMAR').AsString := edtCodMar.Text;
    Open;

    Result := Not IsEmpty;
  End;
  FreeAndNil(qryGen);
End;

procedure TfrmCfgMarcasBosh.pIncluiMarca;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Clear;

    Add('INSERT INTO BOSMAR (');
    Add('  AUTOINCREM, ');
    Add('  BOS_CODEMP, ');
    Add('  BOS_CODMAR  ');
    Add('  ) VALUES (  ');
    Add('  :AUTINC,   ');
    Add('  :CODEMP,    ');
    Add('  :CODMAR)    ');

    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODMAR').AsString := edtCodMar.Text;
    ParamByName('AUTINC').AsString := fRetAutoIncrem('BOSMAR', VS_strCodEmp);

    ExecSQL;
  End;
  FreeAndNil(qryGen);
End;

procedure TfrmCfgMarcasBosh.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
    If fExisteMarca Then
      pMensagemOk('Marca já cadastrada!')
    Else
    Begin
      pIncluiMarca;
      fAbreConsulta;
    End;

  edtCodMar.Clear;
  edtDesMar.Clear;
  pSetFocus(edtCodMar);  

end;

procedure TfrmCfgMarcasBosh.FormShow(Sender: TObject);
begin
  inherited;

  fInsereProCod('BOSMAR');

  blnSempreRelerBanco := False;
  blnTemSelecao       := False;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  fAbreConsulta;

  pSetFocus(edtCodMar);

end;

function TfrmCfgMarcasBosh.fGetSql(blnLike: Boolean): String;
Begin
  Result := '';
  Result := Result + ' SELECT          ';
  Result := Result + '   M.AUTOINCREM, ';
  Result := Result + '   MAR_CODMAR,   ';
  Result := Result + '   MAR_DESMAR    ';
  Result := Result + ' FROM            ';
  Result := Result + '   CADMAR M      ';
  Result := Result + ' INNER JOIN BOSMAR ON MAR_CODMAR = BOS_CODMAR  ';
End;

procedure TfrmCfgMarcasBosh.btnExcluirClick(Sender: TObject);
begin
  inherited;

  With cdsConsulta Do
  If Active And (Not IsEmpty) Then
  Begin
    pExcluiMarca(FieldByName('MAR_CODMAR').AsString);
    fAbreConsulta;
  End;
end;

procedure TfrmCfgMarcasBosh.pExcluiMarca(strCodMar: String);
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Clear;

    Add('DELETE FROM BOSMAR WHERE BOS_CODMAR = :CODMAR');

    ParamByName('CODMAR').AsString := strCodMar;

    ExecSQL;
  End;
  FreeAndNil(qryGen);
End;

end.
