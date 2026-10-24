unit untSelecaoGrupoOperadores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.AppEvnts, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxCalendar, cxTextEdit, cxCurrencyEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, Uni, frxClass, frxExportCSVTestabilidade, Vcl.Menus,
  BitBtnLockedIncrem, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.DBClient, MemDS, DBAccess,untGravando;

type
  TfrmSelecaoGrupoOperadores = class(TfrmPai)
    cxGridSelecaoOperadoresDBTableView1: TcxGridDBTableView;
    cxGridSelecaoOperadoresLevel1: TcxGridLevel;
    cxGridSelecaoOperadores: TcxGrid;
    dsGrupoOperadores: TDataSource;
    cxGridSelecaoOperadoresDBTableView1Column4: TcxGridDBColumn;
    qrySelecaoGrupoOperadores: TUniQuery;
    cxGridSelecaoOperadoresDBTableView1Column1: TcxGridDBColumn;
    btnPermitirAcesso: TBitBtnLocked;
    btnNaoPermitirAcesso: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPermitirAcessoClick(Sender: TObject);
    procedure btnNaoPermitirAcessoClick(Sender: TObject);
  private
    { Private declarations }
    FstrCodPor: String;
    FPermissao: Char;
    procedure RealizarConsulta;
    function RetornaSQLGrupoOperadores: String;
    procedure AlterarPermissaoGrupoOperadores(const AstrOpeAcesso : String);
    procedure AlterarPermissaoGrupoOperadoresExec;
  public
    { Public declarations }
    FDataSourceGrupoOperadores: TDataSource;
    property strCodigoPortador : String read FstrCodPor write FstrCodPor;
    property Permissao : Char read FPermissao write FPermissao;
  end;

var
  frmSelecaoGrupoOperadores: TfrmSelecaoGrupoOperadores;

implementation

{$R *.dfm}

uses untFuncoesSimples, untOperadoresPortador;

{ TfrmSelecaoGrupoOperadores }

procedure TfrmSelecaoGrupoOperadores.AlterarPermissaoGrupoOperadoresExec;
begin
  if Permissao = 'S' then
  begin
    AlterarPermissaoGrupoOperadores('S');
  end
  else if Permissao = 'N' then
  begin
    AlterarPermissaoGrupoOperadores('N');
  end;
end;

procedure TfrmSelecaoGrupoOperadores.btnNaoPermitirAcessoClick(Sender: TObject);
begin
  inherited;
  if fMensagem('ATENÇÃO!', 'Permissão - Grupo de Operadores!' + #13 + 'Deseja não permitir acesso aos grupos de operadores selecionados?', ['&Sim', '&Não'],2) = 1 then
  begin
    Permissao := 'N';
    TfrmGravando.fExecutarModalA(AlterarPermissaoGrupoOperadoresExec,'Aguarde, Realizando Gravações.', '');
    Close;
  end;
end;

procedure TfrmSelecaoGrupoOperadores.btnPermitirAcessoClick(Sender: TObject);
begin
  inherited;
  if fMensagem('ATENÇÃO!', 'Permissão - Grupo de Operadores!' + #13 + 'Deseja permitir acesso aos grupos de operadores selecionados?', ['&Sim', '&Não'],2) = 1 then
  begin
    Permissao := 'S';
    TfrmGravando.fExecutarModalA(AlterarPermissaoGrupoOperadoresExec,'Aguarde, Realizando Gravações.', '');
    Close;
  end;
end;

procedure TfrmSelecaoGrupoOperadores.FormCreate(Sender: TObject);
begin
  inherited;
  qrySelecaoGrupoOperadores := fCriaQuery(Self);
  dsGrupoOperadores.DataSet := qrySelecaoGrupoOperadores;
end;

procedure TfrmSelecaoGrupoOperadores.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qrySelecaoGrupoOperadores);
  FreeAndNil(dsGrupoOperadores);
end;

procedure TfrmSelecaoGrupoOperadores.FormShow(Sender: TObject);
begin
  RealizarConsulta;
end;

procedure TfrmSelecaoGrupoOperadores.RealizarConsulta;
begin
  Try
    qrySelecaoGrupoOperadores.Close;
    qrySelecaoGrupoOperadores.SQL.Clear;
    qrySelecaoGrupoOperadores.SQL.Text := RetornaSQLGrupoOperadores;
    qrySelecaoGrupoOperadores.Open;
    cxGridSelecaoOperadoresDBTableView1.DataController.Refresh;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[RealizarConsulta]');
    End;
  End;
end;

procedure TfrmSelecaoGrupoOperadores.AlterarPermissaoGrupoOperadores(const AstrOpeAcesso : String);
var
  LintCnt: integer;
  LstrOPE_ACESSO : string;
  LstrCodigoGrupo: string;
  LqryOperadoresDoGrupoSelecionado : TUniQuery;
  LqryAtualizacao: TUniquery;
  LstrCodigoOperador : String;
  LstrAtualizacao : String;
begin
  LstrOPE_ACESSO := AstrOpeAcesso;
  fStartTransaction;
  try
    for LintCnt := 0 to cxGridSelecaoOperadoresDBTableView1.DataController.RecordCount - 1 do
    begin
      if cxGridSelecaoOperadoresDBTableView1.DataController.IsRowSelected(LintCnt) then
      begin
        LstrCodigoGrupo := cxGridSelecaoOperadoresDBTableView1.DataController.Values[LintCnt, cxGridSelecaoOperadoresDBTableView1Column1.Index];
        LqryOperadoresDoGrupoSelecionado := fCriaQuery(Self);
        try
          LqryOperadoresDoGrupoSelecionado.Close;
          LqryOperadoresDoGrupoSelecionado.SQL.Clear;
          LqryOperadoresDoGrupoSelecionado.SQL.Text := 'SELECT * FROM OPEGPO WHERE GPO_CODGPO = :CODIGO ;';
          LqryOperadoresDoGrupoSelecionado.ParamByName('CODIGO').AsString := LstrCodigoGrupo;
          LqryOperadoresDoGrupoSelecionado.Open;
          LqryOperadoresDoGrupoSelecionado.First;
          while not LqryOperadoresDoGrupoSelecionado.EOF do
          begin
            LstrCodigoOperador := '';
            LstrCodigoOperador := LqryOperadoresDoGrupoSelecionado.FieldByName('OPE_CODOPE').AsString;

            LqryAtualizacao := fCriaQuery(Self);
            LstrAtualizacao := '';
            LstrAtualizacao := LstrAtualizacao + ' UPDATE POROPE ';
            LstrAtualizacao := LstrAtualizacao + '   SET         ';
            LstrAtualizacao := LstrAtualizacao + '     OPE_ACESSO = :ACESSO ';
            LstrAtualizacao := LstrAtualizacao + ' WHERE                    ';
            LstrAtualizacao := LstrAtualizacao + '   OPE_CODPOR = :CODPOR AND ';
            LstrAtualizacao := LstrAtualizacao + '   OPE_CODOPE = :CODOPE     ';
            LqryAtualizacao.Close;
            LqryAtualizacao.SQL.Clear;
            LqryAtualizacao.SQL.Text := LstrAtualizacao;
            LqryAtualizacao.ParamByName('ACESSO').AsString := LstrOPE_ACESSO;
            LqryAtualizacao.ParamByName('CODPOR').AsString := strCodigoPortador;
            LqryAtualizacao.ParamByName('CODOPE').AsString := LstrCodigoOperador;
            LqryAtualizacao.ExecSQL;

            LqryOperadoresDoGrupoSelecionado.Next;
          end;
        finally
          FreeAndNil(LqryOperadoresDoGrupoSelecionado);
          FreeAndNil(LqryAtualizacao);
        end;
      end;
    end;
    fCommit;
  Except
    fRollBack;
    Raise Exception.Create('Erro ao atualizar operadores do portador ' + strCodigoPortador + '!');
  end;
end;

function TfrmSelecaoGrupoOperadores.RetornaSQLGrupoOperadores: String;
begin
  Result := 'SELECT GPO_CODGPO, GPO_DESCRI FROM CADGPO ORDER BY GPO_CODGPO;';
end;

end.

