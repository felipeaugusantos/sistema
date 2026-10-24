unit untCadTintasBasesAutomotivaDupont;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untCadTintasBasesAutomotiva, AppEvnts, Menus, Mask, DBCtrls,
  DBEditFocus, StdCtrls, Buttons, ComCtrls, ExtCtrls, 
  untICadastroTintaBaseAutomotivaDupont, untIConsulta, DB, Math,
  BitBtnLockedIncrem, Uni;

type
  TfrmCadTintasBasesAutomotivaDupont = class(TfrmCadTintasBasesAutomotiva)
    dbeLinha: TDBEditFocus;
    lblLinha: TLabel;
    dbeTipo: TDBEditFocus;
    lblTipo: TLabel;
    chkPesGra: TDBCheckBox;
    lblCodEmp: TLabel;
    dbeCodEmp: TDBEditFocus;
    btnReplicaItem: TBitBtnLocked;
//    procedure dbeQualidadeKeyPress(Sender: TObject; var Key: Char);
    procedure dbeTipoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeLinhaKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnReplicaItemClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    cadastro: ICadastroTintaBaseAutomotivaDupont;
    consulta: IConsulta;
    procedure pReplicaProdutosParaAsMesmasBasesEmpresasDiferentes;
    procedure pInserirBasesParaOutrasEmpresas;
    procedure pInserirNovasBases(strCodEmp: String);

    function fExisteBaseParaAEmpresa(strCodEmp: String): Boolean;
  protected
    procedure pLigarDataSets; override;
    procedure pSetaEnableReadOnly(DataSet: TDataSet); override;
  public
    constructor Create(AOwner: TComponent; cadastro: ICadastroTintaBaseAutomotivaDupont);
      reintroduce;

    { Public declarations }
  end;

var
  frmCadTintasBasesAutomotivaDupont: TfrmCadTintasBasesAutomotivaDupont;

implementation

uses untCadTintas, untFuncoesSimples;

{$R *.dfm}

{ TfrmCadTintasBasesAutomotivaDupont }

procedure TfrmCadTintasBasesAutomotivaDupont.btnGravarClick(Sender: TObject);
var
  blnInsert: Boolean;
begin
  blnInsert := False;
  If dtsCadastro.State in [dsInsert] Then
    blnInsert := True;

  inherited;

  If fCfgSis('EMPBDU',varBoolean) Then
  Begin
    If blnGravou And blnInsert Then
      pInserirBasesParaOutrasEmpresas;
  End;  
end;

procedure TfrmCadTintasBasesAutomotivaDupont.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If fCfgSis('EMPBDU',varBoolean) Then
  Begin
    dbeCodEmp.Field.ReadOnly := False;
    dbeCodEmp.Field.Text     := VS_strCodEmp;
    dbeCodEmp.Field.ReadOnly := True;
  End;
end;

procedure TfrmCadTintasBasesAutomotivaDupont.btnPesquisaClick(Sender: TObject);
begin
  inherited;
  //Se utilizar codigo da empresa na busca pelas bases entao habilita a replicacao
  //dos produtos para todas as empresas do cadastro de bases.
  If fCfgSis('EMPBDU',varBoolean) Then
  Begin
    With qryTabela Do
    Begin
      btnReplicaItem.Visible := (Not qryTabela.IsEmpty) And (Not fEmptyStr(FieldByName('BAS_CODITE').AsString));
    End;
  End;
end;

procedure TfrmCadTintasBasesAutomotivaDupont.btnReplicaItemClick(
  Sender: TObject);
begin
  inherited;
  With qryTabela Do
  Begin
    If Not fEmptyStr(FieldByName('BAS_CODITE').AsString) Then
    Begin
      If fMensagem('AVISO', 'Deseja realmente replicar os itens para as bases semelhantes?', ['&Sim', '&Não']) = 1 Then
        pReplicaProdutosParaAsMesmasBasesEmpresasDiferentes;
    End;
  End;
end;

constructor TfrmCadTintasBasesAutomotivaDupont.Create(AOwner: TComponent;
  cadastro: ICadastroTintaBaseAutomotivaDupont);
begin
  Self.cadastro := cadastro;
  Self.consulta := cadastro.fGetConsulta;
  inherited Create(AOwner, cadastro);
end;


procedure TfrmCadTintasBasesAutomotivaDupont.pInserirBasesParaOutrasEmpresas;
var
  qryCons: TUniQuery;
begin
  Try
    Try
      fStartTransaction;
      qryCons := fCriaQuery(nil);
      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT EMP_CODEMP ');
        SQL.Add('   FROM CADEMP ');
        SQL.Add('  WHERE EMP_CODEMP <> :CODEMP ');
        SQL.Add('  ORDER BY EMP_CODEMP ');
        ParamByName('CODEMP').AsString := qryCadastro.FieldByName('BAS_CODEMP').AsString;
        Open;

        If Not IsEmpty Then
        Begin
          First;
          While Not Eof Do
          Begin

            If Not fExisteBaseParaAEmpresa(FieldByName('EMP_CODEMP').AsString) Then
              pInserirNovasBases(FieldByName('EMP_CODEMP').AsString);

            Next;
          End;
          fCommit;
        End
        Else
          fRollBack;

      End;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[pInserirBasesParaOutrasEmpresas]');
      end;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

procedure TfrmCadTintasBasesAutomotivaDupont.pInserirNovasBases(
  strCodEmp: String);
var
  qryIns: TUniQuery;
begin
  Try
    Try
      qryIns := fCriaQuery(qryIns);
      With qryIns Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' INSERT INTO DUP_CADBAS ');
        SQL.Add(' (                      ');
        SQL.Add('       BAS_CODBAS ,');
        SQL.Add('       BAS_CODEMP ,');
        SQL.Add('       BAS_CODITE ,');
        SQL.Add('       BAS_DESBAS ,');
        SQL.Add('       BAS_EMBALA ,');
        SQL.Add('       BAS_PESESP ,');
        SQL.Add('       BAS_PRECUS ,');
        SQL.Add('       BAS_MARGEM ,');
        SQL.Add('       BAS_PREVEN ,');
        SQL.Add('       AUTOINCREM ,');
        SQL.Add('       BAS_QUALID ,');
        SQL.Add('       BAS_TIPO__ ,');
        SQL.Add('       BAS_LINHA_  ');
        SQL.Add(' )                      ');
        SQL.Add('        VALUES          ');
        SQL.Add(' (                      ');
        SQL.Add('       :CODBAS ,');
        SQL.Add('       :CODEMP ,');
        SQL.Add('       :CODITE ,');
        SQL.Add('       :DESBAS ,');
        SQL.Add('       :EMBALA ,');
        SQL.Add('       :PESESP ,');
        SQL.Add('       :PRECUS ,');
        SQL.Add('       :MARGEM ,');
        SQL.Add('       :PREVEN ,');
        SQL.Add('       :AUTOIN ,');
        SQL.Add('       :PESGRA ,');
        SQL.Add('       :TIPO__ ,');
        SQL.Add('       :LINHA_  ');
        SQL.Add(' )                      ');

        ParamByName('CODBAS').AsString := qryCadastro.FieldByName('BAS_CODBAS').AsString;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODITE').AsString := qryCadastro.FieldByName('BAS_CODITE').AsString;
        ParamByName('DESBAS').AsString := qryCadastro.FieldByName('BAS_DESBAS').AsString;
        ParamByName('EMBALA').AsFloat  := qryCadastro.FieldByName('BAS_EMBALA').AsFloat;
        ParamByName('PESESP').AsFloat  := qryCadastro.FieldByName('BAS_PESESP').AsFloat;
        ParamByName('PRECUS').AsFloat  := qryCadastro.FieldByName('BAS_PRECUS').AsFloat;
        ParamByName('MARGEM').AsFloat  := qryCadastro.FieldByName('BAS_MARGEM').AsFloat;
        ParamByName('PREVEN').AsFloat  := qryCadastro.FieldByName('BAS_PREVEN').AsFloat;
        ParamByName('AUTOIN').AsString := fRetAutoIncrem('DUP_CADBAS', strCodEmp);
        ParamByName('PESGRA').AsString := qryCadastro.FieldByName('BAS_PESGRA').AsString;
        ParamByName('TIPO__').AsString := qryCadastro.FieldByName('BAS_TIPO__').AsString;
        ParamByName('LINHA_').AsString := qryCadastro.FieldByName('BAS_LINHA_').AsString;

        ExecSQL;
      End;
    Except
      on E: Exception do
      begin
        fMensagem('INFORMAÇÃO','Erro ao inserir nova base automaticamente por empresa!',['&Ok']);
      end;
    End;
  Finally
    FreeAndNil(qryIns);
  End;
end;

procedure TfrmCadTintasBasesAutomotivaDupont.pLigarDataSets;
begin
  inherited pLigarDataSets;
  pLigarDataSets(dbeLinha, lblLinha, cadastro.fGetCampoLinha);
  pLigarDataSets(dbeTipo, lblTipo, cadastro.fGetCampoTipo);
//  pLigarDataSets(dbeQualidade, lblQualidade, cadastro.fGetCampoQualidade);
  pLigarDataSets(nil, nil, cadastro.fGetCampoPesoGrama, chkPesGra);
  If fCfgSis('EMPBDU',varBoolean) Then
    pLigarDataSets(dbeCodEmp, lblCodEmp, cadastro.fGetCampoEmpresa);
{
  chkPesGra.DataField := cadastro.fGetCampoPesoGrama;
  chkPesGra.Visible := Not fEmptyStr(cadastro.fGetCampoPesoGrama);
  chkPesGra.Tag := IfThen(chkPesGra.Visible, 99, 0);
}
end;

procedure TfrmCadTintasBasesAutomotivaDupont.pReplicaProdutosParaAsMesmasBasesEmpresasDiferentes;
var
  qryCons: TUniQuery;
begin
  Try
    Try
      fStartTransaction;
      qryCons := fCriaQuery(nil);
      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT BAS_CODBAS, ');
        SQL.Add('        BAS_CODITE, ');
        SQL.Add('        BAS_CODEMP  ');
        SQL.Add('   FROM DUP_CADBAS  ');
        SQL.Add('  WHERE BAS_CODBAS = :CODBAS  ');
        SQL.Add('    AND BAS_CODEMP <> :EMPBAS ');
        SQL.Add('  ORDER BY BAS_CODEMP ');
        ParamByName('CODBAS').AsString := qryCadastro.FieldByName('BAS_CODBAS').AsString;
        ParamByName('EMPBAS').AsString := qryCadastro.FieldByName('BAS_CODEMP').AsString;
        Open;

        If Not IsEmpty Then
        Begin
          While Not Eof Do
          Begin
            Edit;
            FieldByName('BAS_CODITE').AsString := qryCadastro.FieldByName('BAS_CODITE').AsString;
            Post;

            Next;
          End;
          fCommit;
          fMensagem('Informação','Produto: ' + qryTabela.FieldByName('BAS_CODITE').AsString + #13#10 +
                                ' replicado com sucesso para a base: ' + qryTabela.FieldByName('BAS_CODBAS').AsString,['&Ok']);
        End
        Else
        Begin
          fRollBack;
          fMensagem('Informação','Não existem bases para serem replicadas!',['&Ok']);
        End;

      End;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[pReplicaProdutosParaAsMesmasBasesEmpresasDiferentes]');
      end;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

{procedure TfrmCadTintasBasesAutomotivaDupont.dbeQualidadeKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrQualidade: untICadastroTintaBaseAutomotivaDupont.TStringArray;
begin
  inherited;
  If (fEntraCons(Key)) And (Not dbeQualidade.ReadOnly) Then
  Begin
    Key := #0;
    arrQualidade := cadastro.fGetArrayQualidades;
    dbeQualidade.Field.AsString := arrQualidade[fGetMenu('Escolha a qualidade', arrQualidade, 1) - 1];
    SelectNext(ActiveControl, True, True);
  End;
end;}

procedure TfrmCadTintasBasesAutomotivaDupont.dbeTipoKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrTipo: untICadastroTintaBaseAutomotivaDupont.TStringArrayDup;
begin
  If (fEntraCons(Key)) And (Not dbeTipo.ReadOnly) Then
  Begin
    Key := #0;
    arrTipo := cadastro.fGetArrayTipos;
    dbeTipo.Field.AsString := arrTipo[fGetMenu('Escolha o tipo', arrTipo, 1) - 1];
    SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadTintasBasesAutomotivaDupont.fExisteBaseParaAEmpresa(
  strCodEmp: String): Boolean;
var
  qryCons: TUniQuery;
begin
  Result := True;

  Try
    Try
      qryCons := fCriaQuery(nil);
      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT BAS_CODBAS ');
        SQL.Add('   FROM DUP_CADBAS ');
        SQL.Add('  WHERE BAS_CODBAS = :CODBAS ');
        SQL.Add('    AND BAS_CODEMP = :CODEMP ');
//        SQL.Add('    AND BAS_TIPO__ = :TIPO__ ');
        ParamByName('CODBAS').AsString := qryCadastro.FieldByName('BAS_CODBAS').AsString;
        ParamByName('CODEMP').AsString := strCodEmp;
//        ParamByName('TIPO__').AsString := qryCadastro.FieldByName('BAS_TIPO__').AsString;
        Open;
        If IsEmpty Then
          Result := False;
      End;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[fExisteBaseParaAEmpresa]');
      end;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

procedure TfrmCadTintasBasesAutomotivaDupont.FormShow(Sender: TObject);
begin
  inherited;
  dbeCodEmp.Visible := fCfgSis('EMPBDU',varBoolean);
  lblCodEmp.Visible := dbeCodEmp.Visible;
  If Not dbeCodEmp.Visible Then
  Begin
    dbeDescricao.Left := dbePesoEspecifico.Left + dbePesoEspecifico.Width - dbeDescricao.Width;
    lblDescricao.Left := dbeDescricao.Left - 56;
  End;
end;

procedure TfrmCadTintasBasesAutomotivaDupont.dbeLinhaKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrLinha: untICadastroTintaBaseAutomotivaDupont.TStringArrayDup;
begin
  inherited;
  If (fEntraCons(Key)) And (Not dbeLinha.ReadOnly) Then
  Begin
    Key := #0;
    arrLinha := cadastro.fGetArrayLinhas;
    dbeLinha.Field.AsString := arrLinha[fGetMenu('Escolha a linha', arrLinha, 1) - 1];
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadTintasBasesAutomotivaDupont.pSetaEnableReadOnly(
  DataSet: TDataSet);
begin
  inherited pSetaEnableReadOnly(DataSet);
end;

end.
