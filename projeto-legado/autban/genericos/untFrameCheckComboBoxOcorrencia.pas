unit untFrameCheckComboBoxOcorrencia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxCheckBox, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCheckComboBox, Uni, untTypesSistema,
  System.StrUtils;

type
  TfraCheckComboBoxOcorrencia = class(TFrame)
    chkcbOcorrencia: TcxCheckComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
    strCodBco: String;          //código do banco
    strCnab: String;            //tipo CNAB (240, 400, 6D, 7D, etc)
    strCodIgnora: TStringArray; //códigos de ocorrência a ignorar ao montar o combo

    procedure pCarregaOcorrencias;
    procedure pSetOcorrencias(const strSelec: String);
    function fGetOcorrencias: String;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfraCheckComboBoxOcorrencia }

procedure TfraCheckComboBoxOcorrencia.pCarregaOcorrencias;
  Var
    qryOco: TUniQuery;
begin
  chkcbOcorrencia.Properties.Items.Clear;

  Try
    qryOco := fCriaQuery(Self);
    qryOco.SQL.Add('SELECT OCO_CODOCO, CONCAT(OCO_CODOCO, " - ", OCO_DESCRI) OCO_DESCRI');
    qryOco.SQL.Add('FROM OCOBAN');
    qryOco.SQL.Add('WHERE OCO_CODBCO = :CODBCO');
    qryOco.SQL.Add('AND OCO_OPCNAB = :OPCNAB');

    If Length(strCodIgnora) > 0 Then
      qryOco.SQL.Add('AND OCO_CODOCO NOT IN ('+ strCodIgnora.ToString(',', True) +')');

    qryOco.SQL.Add('ORDER BY OCO_CODOCO');

    qryOco.ParamByName('CODBCO').AsString := strCodBco;
    qryOco.ParamByName('OPCNAB').AsString := strCnab;
    qryOco.Open;

    qryOco.First;
    While Not qryOco.Eof Do
    Begin
      chkcbOcorrencia.Properties.Items.AddCheckItem(qryOco.FieldByName('OCO_DESCRI').AsString,
                                                    qryOco.FieldByName('OCO_CODOCO').AsString);
      qryOco.Next;
    End;
  Finally
    FreeAndNil(qryOco);
  End;
end;

function TfraCheckComboBoxOcorrencia.fGetOcorrencias: String;
  Var
    intIndex: Integer;
begin
  Result := EmptyStr;

  For intIndex := 0 To chkcbOcorrencia.Properties.Items.Count -1 Do
    If chkcbOcorrencia.States[intIndex] = cbsChecked Then
      Result := Result + chkcbOcorrencia.Properties.Items[intIndex].ShortDescription + chkcbOcorrencia.Properties.Delimiter;
end;

procedure TfraCheckComboBoxOcorrencia.pSetOcorrencias(const strSelec: String);
  Var
    intIndex: Integer;
    arrSelecao: TArray<String>;
begin
  arrSelecao := strSelec.Split([chkcbOcorrencia.Properties.Delimiter]);

  For intIndex := 0 To chkcbOcorrencia.Properties.Items.Count -1 Do
    If MatchStr(chkcbOcorrencia.Properties.Items[intIndex].ShortDescription, arrSelecao) Then
      chkcbOcorrencia.States[intIndex] := cbsChecked
    Else
      chkcbOcorrencia.States[intIndex] := cbsUnchecked;
end;

end.
