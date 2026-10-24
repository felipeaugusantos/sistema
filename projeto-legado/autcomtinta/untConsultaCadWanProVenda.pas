unit untConsultaCadWanProVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, Mask, DBCtrls, DBEditFocus, DB,
    Uni, ExtCtrls, StdCtrls,
  ComCtrls, Buttons, Grids, DBGridCitel, DBGrids, StrUtils, BitBtnLockedIncrem, MemDS,
  DBAccess;

type
  TfrmConsultaCadWanProVenda = class(TfrmConsultaComp)
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExecutaTarefaClick(Sender: TObject);
  private
    { Private declarations }
    procedure pDesabilitaColunas;
  protected
    procedure pAtuIndice(intIndice: Integer); override;
    function fMontaSQL: String; overload; override;
  public
    { Public declarations }
  end;

var
  frmConsultaCadWanProVenda: TfrmConsultaCadWanProVenda;

implementation

uses untFuncoesSimples, untFuncoes;

{$R *.dfm}

{ TfrmConsultaComp1 }

procedure TfrmConsultaCadWanProVenda.pAtuIndice(intIndice: Integer);
  Var
    strSQL: String;
    strSQLOrder: String;
    strOrder: String;
    intPos: Integer;
begin
  Try

    strSQL := '';
    strSQLOrder := fRetOrderBy(lstConInd.Strings[intIndice]);

    If blnPrimeiraVez Then
      strSQLConsultaOri := strSQLConsulta;

    If (Not fEmptyStr(strUltSelect)) And (blnPrimeiraVez) Then
    Begin
      lstIndices.ItemIndex := intUltItemIndex;
      strSQL               := strUltSelect;

      If (blnIniciaVazio) Then
      Begin
        If (RightStr(Trim(strSQL), 7) <> 'LIMIT 0') Then
          strSQL := strSQL + ' LIMIT 0 ';
      End;

    End
    Else
    Begin
      If (Pos('ORDER BY', strOrderOpc) > 0) Then
      Begin
        strSQL := strSQLConsulta + ' ' + strOrderOpc;
        strSQLOrder := '';
      End
      Else
      Begin
        strSQL := strSQLConsulta + ' ORDER BY ' + strSQLOrder + strOrderOpc;
      End;
//      If (Not blnMostraTudo) Or ((blnPrimeiraVez) And (blnIniciaVazio)) Then
      If (Not blnMostraTudo) Or (blnIniciaVazio) Then
        strSQL := strSQL + ' LIMIT 0 ';

    End;

    If Pos('GROUP BY', strSQL) <= 0 Then
    Begin
      intPos := Pos('ORDER BY', strSQL);

      strOrder := '';
      If intPos > 0 Then
      Begin
        strOrder := Copy(strSQL, intPos, Length(strSQL));
        strSQL := LeftStr(strSQL, intPos-1) + ' ';
      End;

      strSQL := strSQL + ' GROUP BY WAN_CODAKZ, WAN_ALTERN ';

      If Not fEmptyStr(strOrder) Then
        strSQL := strSQL + strOrder;
    End;

    blnPrimeiraVez := False;

    With qryConsulta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      qryConsulta.DisableControls;
      If blnRestauraGrid Then
        qryConsulta.EnableControls;
    End;

    pAjustaEdits;
    //pDefCampos;
    pAlinhaColunasNumericas;
    
    If qryConsulta.FieldDefList.Find('AUTOINCREM') <> Nil Then
      qryConsulta.FieldByName('AUTOINCREM').Visible := False;

    If qryConsulta.FieldDefList.Find('MARDES') <> Nil Then
      qryConsulta.FieldByName('MARDES').Visible := False;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmConsultaComp -> pAtuIndice]');
    End;
  End;
  Screen.Cursor := crDefault;


  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaCadWanProVenda.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('AUTOINCREM').Visible := False;
end;

procedure TfrmConsultaCadWanProVenda.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadWanProVenda.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadWanProVenda.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

function TfrmConsultaCadWanProVenda.fMontaSQL: String;
  Var
    intPos: Integer;
    strOrder: String;
begin
  Result := '';
  Result := inherited fMontaSQL;
  intPos := Pos('ORDER BY', Result);

  strOrder := '';
  If intPos > 0 Then
  Begin
    strOrder := Copy(Result, intPos, Length(Result));
    Result := LeftStr(Result, intPos-1) + ' ';
  End;

  Result := Result + ' GROUP BY WAN_CODAKZ, WAN_ALTERN ';

  If Not fEmptyStr(strOrder) Then
    Result := Result + strOrder;

end;

procedure TfrmConsultaCadWanProVenda.btnExecutaTarefaClick(
  Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadWanProNovasFormulas', False);
end;

end.
